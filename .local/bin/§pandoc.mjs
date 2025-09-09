#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
if(!s.which("pandoc")) throw new Error("pandoc not found. Use your package manager to install it (e.g. `sudo apt install pandoc`).");
const pdftk= "§pdftk-data.mjs";
if(!s.which(pdftk)) throw new Error(`${pdftk} user script not found.`);

$.api()
	.version("2025-09-04")
	.describe([
		"Small wrapper around `pandoc` mainly to convert markdown to pdf.",
		"The reason is to use modern CSS than rely on cli implementation to converting to pdf."
	])
	.option("--debug", "Debug mode")
	.option("--force", "Overwrite output file.")

	.command("to-html <name-input> [name-output]", "Convert markdown to html.")
	.alias("tohtml")
	.action(function tohtmlCMD(input, output, options){
		tohtml(input, output, options);
		$.exit(0);
	})

	.command("to-pdf <name-input> [name-output]", "Convert markdown to pdf.")
	.alias("topdf")
	.action(async function topdfCMD(input, output, options){
		const { force: isForced, debug: isDebug }= options;
		testInput(input);
		output= normalizeOutput(input, ".pdf", output, isForced);
		const tempFile= tempFileGenerator(input);
		
		echo("1. step: convert to html");
		const output_html= tempFile(".html");
		const input_data= tohtml(input, output_html, options);
		
		echo("2. step: convert to pdf");
		echo("	…use print to pdf in your browser");
		s.run`open ${output_html}`;
		await s.read({ "-p": "Press enter to continue" }).catch(()=> echo("Aborted"));
		if(!isDebug) s.rm(output_html);
		if(!s.test("-f", output))
			$.error("Output file not found");
		
		echo("3. step: update pdf metadata");
		const output_data_file= tempFile(".json");
		echo(`	${pdftk} extract \${pdf}`);
		s.run`${pdftk} extract ${output} ${output_data_file}`;
		const output_data= s.cat(output_data_file).xargs(JSON.parse);
		const { Creator }= output_data.Info;
		input_data.Creator= [
			s.$().run`pandoc --version`.head({ "-n": 1 }).trim(),
			"&",
			Creator,
		].join(" ");
		Object.assign(output_data.Info, input_data);
		s.echo(JSON.stringify(output_data, null, "\t")).to(output_data_file);
		echo(`	${pdftk} update \${pdf}`);
		s.run`${pdftk} update ${output} ${output_data_file}`;
		if(!isDebug) s.rm(output_data_file);
		
		$.exit(0);
	})
	.parse();

/**
 * @param {string} input
 * @param {string} [output]
 * @param {object} options
 * @returns {Record<string, string>}
 * */
function tohtml(
	input, output,
	{ force: isForced, debug: isDebug }
){
	testInput(input);
	output= normalizeOutput(input, ".html", output, isForced);
	const tempFile= tempFileGenerator(input);
	
	const { input_tmp, input_data }= prepareInput(input, tempFile);
	echo("	pandoc ${markdown} --standalone -o ${html}");
	s.run`pandoc ${input_tmp} --standalone -o ${output}`;
	if(!isDebug) s.rm(input_tmp);
	return input_data;
}
/** @param {string} orig */
function tempFileGenerator(orig){
	const basepath= orig.includes("/") ? orig.slice(0, orig.lastIndexOf("/")+1) : "";
	const basename= orig.slice(basepath.length, orig.lastIndexOf("."));
	return ext=> basepath+"."+basename+"-"+nameHash()+ext;
}
/**
 * @param {string} input
 * @param {(ext: string)=> string} tempFile
 * @returns {{ input_tmp: string, input_data: Record<string, string> }}
 * */
function prepareInput(input, tempFile){
	const input_tmp= tempFile(".md");
	const content= s.cat(input).trim();
	let input_data= {};
	echo("	extract input metadata and eval `~` to $HOME (CSS)");
	if(content.startsWith("---"))
		for(const line_raw of content.split("\n").slice(1)){
			const line= line_raw.trim();
			if(!line) continue;
			if(line==="---") break;
			const [key_raw, value]= line.split(/: */);
			let key= key_raw.replace(/^-+/, "");
			key= key[0].toUpperCase()+key.slice(1);
			input_data[key]= value;
		}
	s.echo(content.replaceAll("file:///~", "file:///"+process.env.HOME)).to(input_tmp);
	return { input_tmp, input_data };
}
/**
	* @param {string} input Input file
	* @param {string} ext Output file extension
	* @param {string} [output] Output file
	* @param {boolean} [isForced] Overwrite output file
	* @returns {string}
	* @throws {Error} When output file already exists (unless `--force`)
	* */
function normalizeOutput(input, ext, output, isForced){
	if(!output) output= input.slice(0, input.lastIndexOf("."))+ext;
	if(s.test("-f", output)) {
		if(!isForced) $.error("Output file already exists, choose another name or `--force`");
		s.rm(output);
	}
	return output;
}
/** @param {string} input @throws {Error} If input file not found */
function testInput(input){ if(!s.test("-f", input)) $.error("Input file not found"); }
function nameHash(){ return Math.random().toString(36).slice(2); }
