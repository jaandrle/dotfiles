#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
$.is_fatal= true;
const token_file= "~/.config/openai.token";
let token;
const gitmoji_list= {
		build: "building_construction",
		chore: "bricks",
		ci: "construction_worker",
		docs: "memo",
		feat: "sparkles",
		fix: "bug",
		perf: "zap",
		refactor: "recycle",
		revert: "rewind",
		style: "art",
		test: "white_check_mark"
};
const git3moji_list= {
		build: "tv",
		chore: "tv",
		ci: "tv",
		docs: "abc",
		feat: "zap",
		fix: "bug",
		perf: "zap",
		refactor: "cop",
		style: "zap",
		test: "cop"
};
const conventional_desc= [
		"Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)",
		"Other changes that don't modify src or test files",
		"Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)",
		"Documentation only changes",
		"A new feature",
		"A bug Fix",
		"A code change that improves performance",
		"A code change that neither fixes a bug nor adds a feature",
		"Reverts a previous commit",
		"Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)",
		"Adding missing tests or correcting existing tests"
];

$.api("", true)
	.version("2024-02-28")
	.describe([
		"Utility to use ChatGPT to generate a commit message from COMMIT_EDITMSG file.",
		`Don't forget to set the token in ${token_file} file.`,
		"",
		"Conventional/gitmoji commits should follow https://www.conventionalcommits.org/en/v1.0.0/ (https://github.com/pvdlg/conventional-commit-types).",
		"For the gitmoji the <type> uses emojis as follows:",
		...Object.entries(gitmoji_list).map(( v, i )=> echo.format("%c"+v[0]+` (${v[1]}): ${conventional_desc[i]}`, "display: list-item")),
		...Object.entries(git3moji_list).map(( v, i )=> echo.format("%c"+v[0]+` (${v[1]}): ${conventional_desc[i]}`, "display: list-item"))
	])
	.option("--format, -f", [ "Use one of the following formats to generate the commit message: [regular (default), conventional, gitmoji, git3moji]",
		"For gitmoji see: https://gitmoji.dev/"
		])
	.action(async function({ format= "regular" }= {}){
		const question= questionChatGPT(format);
		const response= (await pipe(
			()=> s.cat("./.git/COMMIT_EDITMSG"),
			s=> s.slice(s.indexOf("diff --git")),
			diffToChunks(3900-545), //the worst scenario of ★ +new lines
			ch=> ch.map(pipe( question, requestCommitMessage )),
			ch=> Promise.all(ch)
		)())
			.map(pipe(
				j=> j.choices[0].text.trim(),
				convertToArray,
				format==="regular" || format==="conventional" ? i=> i : i=> gitmoji(i, format==="git3moji"),
				a=> a.join("\n")
			))
			.join("\n\n");
		echo(response);
		$.exit(0);
	})
	.parse();

function diffToChunks(max_tokens){ return function(input){
	if(input.length < max_tokens)
		return [ input ];
	
	return input.split(/(?=diff --git)/g)
		.flatMap(function(input){
			if(input.length < max_tokens)
				return [ input ];
			
			const [ file, ...diffs ]= input.split(/\n(?=@@)/g);
			if(file.includes("new file"))
				return [ file ];
			return diffs
				.filter(chunk=> chunk.length < max_tokens)
				.reduce(function(chunks, chunk){
					const i= chunks.length-1;
					if(chunks[i].length + chunk.length < max_tokens-1)
						chunks[i]+= "\n"+chunk;
					else
						chunks.push(file+"\n"+chunk);
					return chunks;
				}, [ file ])
				.filter(chunk=> chunk.length < max_tokens);
		});
}; }
function convertToArray(text){
	// console.log(text);
	return text.split("\n")
		.map(line=> line.trim())
		.filter(line=> line.trim())
		.map(function(line){
			if(/^[0-9-].? /.test(line)) line= line.slice(line.indexOf(" ")+1);
			if(/^["']/.test(line[0])) line= line.slice(1);
			if(/["']$/.test(line[line.length-1])) line= line.slice(0, -1);
			return line;
		})
	;
}
function questionChatGPT(format){ return function(diff){
	const msg= [
		[
			"I would like to ask you to act like a git commit message writer.",
			"I will enter a git diff, and your job is to convert it into a useful commit message",
			"Make 3 options, one option per line.",
			"Do not preface the commit with anything, use a concise, precise, present-tense, complete sentence.",
			"The length should be fewer than 50 characters if possible.",
		].join(" ") //340chars★
	];
	if(format!=="regular")
		msg.push(
			[
				"It should follow the conventional commits.",
				"The format is <type in lowercase>: <description>.",
				"A type can be one of the following: build, chore, ci, docs, feat, fix, perf, refactor, revert, style, or test.",
			].join(" ") //203chars★
		);
	msg.push("", diff);
	return msg.join("\n");
}; }
function gitmoji(candidates, is_three= false){
	return candidates.map(message=> message.trim().replace(/^[^:]*:/, toGitmoji));

	function toGitmoji(name){
		const candidate= ( is_three ? git3moji_list : gitmoji_list )[name.slice(0, -1)];
		return !candidate ? name : `:${candidate}:`;
	}
}
function requestCommitMessage(prompt){
	if(!token) token= s.cat(token_file).stdout.trim();
	const model= "gpt-3.5-turbo-instruct";
	return fetch(`https://api.openai.com/v1/engines/${model}/completions`, {
		method: "POST",
		headers: {
			"Content-Type": "application/json",
			"Authorization": "Bearer "+token
		},
		body: JSON.stringify({
			max_tokens: 1000,
			temperature: 0.1,
			prompt
		}),
		signal: AbortSignal.timeout(10000)
	}).then(r=> r.json());
}
// vim: set tabstop=4 shiftwidth=4 textwidth=250 noexpandtab :
// vim>60: set foldmethod=indent foldlevel=1 foldnestmax=2:
