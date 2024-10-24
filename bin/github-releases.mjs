#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
// "\x1b[38;2;150;150;150m"
// https://talyian.github.io/ansicolors/
/**
 * Represents a package record stored locally
 *
 * @typedef ConfigPackage
 * @type {Object}
 * @property {string} repository - Repo in the form `<owner>/<repo>`
 * @property {string} name - Name/Identifier
 * @property {string} description - A description of the repo/package
 * @property {string} file_name - The name of the file as stored locally
 * @property {"yes"|"no"} exec - Whether the file is executable
 * @property {string} last_update - The date and time of the last update
 * @property {string} downloads - The path to the file
 * @property {string} version - The version of the file
 * @property {string} tag_name_regex - Filter only matching releases
 * */
/**
 * @typedef Config
 * @type {{ packages: ConfigPackage[] }}
 * */
/**
 * Represents a GitHub release information.
 *
 * @typedef {Object} GitHubRelease
 * @property {number} id - The ID of the GitHub release.
 * @property {string} url - The URL of the GitHub release.
 * @property {string} assets_url - The URL of the assets associated with the GitHub release.
 * @property {string} html_url - The HTML URL of the GitHub release.
 * @property {string} tag_name - The tag name of the GitHub release.
 * @property {string} published_at - The publication date of the GitHub release.
 */
import { join } from "node:path";
const path_config= $.xdg.config`github-releases`;
const paths= {
	/** config file path — JSON stringify of {@link Config} */	config: join(path_config, "config.json"),
	/** path to lock file to prevent multiple instances */		lock: join(path_config, "lock"),
};
const path_temp= $.xdg.temp`github-releases.json`;
let url_api= "github";
const urls_api= {
	github: "https://api.github.com/repos/",
	ungh: "https://ungh.cc/repos/"
};
const url_download= "https://glare.now.sh/"; // https://github.com/Contextualist/glare
const css= echo.css`
	.pkg { color: lightcyan; }
	.ok { color: lightgreen; }
	.err { color: lightred; }
	.skip { color: red; color: gray; }
	.spin { display: list-item; list-style: --terminal-spin; }
`;

$.api()
	.version("2.2.0")
	.describe("Helper for working with “packages” stored in GitHub releases.")
	.option("--verbose", "Verbose output (WIP)")
	.option("--group, -G", "Filter by group (not awaiable for noGRA)")
	.option("--repository, -R", "Filter by repository (not awaiable for noGRA)")
	.option("--api", [ "Choose API URL",  
		"- GitHub (default): https://api.github.com/repos/",
		"- Ungh: https://ungh.cc/repos/", "(not awaiable for noGRA)" ], "github")
.command("unlock", "[noGRA] DANGER: Removes lock file. Use only if you know what you are doing!")
	.action(function(){
		s.rm(paths.lock);
	})
.command("config [mode]", [ "[noGRA] Config (file), use `mode` with these options:",
		"- `edit`: opens config file in terminal editor using `$EDITOR` (defaults to vim)",
		"- `path`: prints path to config file"
	])
	.action(async function(mode= "path"){
		switch(mode){
			case "path": echo(paths.config); break;
			case "edit":
				const editor= $.env.EDITOR || "vim";
				await s.runA`${editor} ${paths.config}`.pipe(process.stdout);
				break;
			default:
				echo(`Unknown mode: '${mode}'. See '--help' for details.`);
		}
		$.exit(0);
	})
.command("edit <repository>", "Edit “package” information")
	.alias("add")
	.action(async function(repository){
		if(!repository || !repository.includes("/"))
			$.error(`Invalid repository: '${repository}'. Repository must be in the form '<owner>/<repo>'.`);
		const config= /** @type {Config} */ ( readConfig() );
		const i= config.packages.findIndex(r=> r.repository===repository);
		echo(repository + ` — ${i==-1 ? "New" : "Edit"} package:`);
		echo(`Use <tab> to autocomplete${i===-1 ? "" : " and empty to keep current value"}.`);
		echo("");
		const pkg= config.packages[i] || { repository, group: "" };
		const groups= [ ...new Set(config.packages.map(r=> r.group)) ];
		const q= (question, initial, ...c)=> {
			const completions= [ ...new Set([initial, ...c.flat()]) ].filter(Boolean);
			if(initial) question+= ` (current \`${initial}\`)`;
			question= echo.format("%c"+question, css.pkg);
			return s.read({ "-p": question+": ", completions }).then(pipe(
				value=> value || initial,
				value=> value ? value : $.error(`Missing '${question}'.`)
			));
		};
		
		try{
			const name= await q("Name", pkg.name);
			echo("(i) use `skip` as part of the group to skip it during checking/updating (“just register package”).");
			const group= await q("Group", pkg.group, groups);
			const { description: description_remote }= await fetch(urls_api[url_api]+repository).then(r=> r.json()).catch(_=> ({}));
			const description= await q("Description", pkg.description, description_remote);
			const file_name= await q("File name", pkg.file_name, repository.split("/"));
			const downloads= config.target+file_name;
			const exec= await q("Is executable", pkg.exec, [ "yes", "no" ]);
			echo("(i) The glare is used to determine the right file to download. It is regular expression.");
			const glare= await q("Glare", pkg.glare);
		
			const pkg_edit= Object.assign({}, pkg,
				{ repository, name, description, group, file_name, exec, downloads, glare });
			config.packages[i===-1 ? config.packages.length : i]= pkg_edit;
			s.echo(JSON.stringify(config, null, "\t")).to(paths.config);
			echo(`%cSaved into config file '${paths.config}'.`, css.ok);
			$.exit(0);
		} catch(e){
			if(e instanceof $.Error) echo("%c"+e, css.err);
			else echo();
			$.exit(1);
		}
	})
.command("ls", [ "Lists registered packages",
		"Repositories marked with `-` signifies that the package is in the 'skip' group.",
		"These are registered by this script but not managed by it (updates, etc).",
		"Repositories marked with `+` signify that updates of the package are checked."
	])
	.action(function(filter){
		const config = readConfig();
		for(const { repository, version, description, group } of grepPackages(config, filter))
			if(group && !group.includes("skip"))
				echo(`+ %c${repository}%c@${version ? version : "—"}: %c${description}`, css.pkg, css.unset, css.skip);
			else
				echo(`- %c${repository}: ${description}`, css.skip);
		$.exit(0);
	})
.command("check", "Shows/checks updates for registered packages")
	.option("--cache", "Use cache [yes, no]", "yes")
	.action(async function({ cache, ...filter }){
		const config = readConfig();
		const results= await check(grepPackages(config, filter), cache);
		for(const { status, value } of results)
			echoPkgStatus(status, value);
		if(!results.length) echo("Nothing to do.");
		$.exit(0);
	})
.command("update", "Updates registered packages")
	.action(async function(filter){
		if(s.test("-f", paths.lock))
			return $.error(`The lock file '${paths.lock}' already exists! Check if some other instance is running.`);
		s.touch(paths.lock);
		const config = readConfig();
		const results= await check(grepPackages(config, filter));
		let done= 0;
		let todo= [];
		echo("Collecting packages to update…");
		for(const { status, value } of results){
			if(status!==3 || (value.local.group || "skip").includes("skip")) continue;
			echo("%c"+value.local.repository, css.pkg);
			todo.push(download(
				value,
				()=> done+= 1,
				config.target
			));
		}
		const { length }= todo;
		if(!length){
			echo("%cAll up-to-date!%c Nothing to do.", css.ok);
		} else {
			const id= setInterval(()=>
				echo.use("-R", `%cUpdating packages (${done}/${length})`, css.spin), 500);
			const updates= await Promise.allSettled(todo);
			clearInterval(id);
			echo("Updating packages completed:");
			for (const { status, value, reason } of updates) {
				if(status==="rejected"){
					echo("%c✗ TBD reason.local.repository: %c"+reason.err, css.err);
					continue;
				}
				const { local, remote }= value;
				echo("%c✓ "+local.repository+"%c@"+remote.tag_name, css.ok, css.skip);
			}
			s.echo(JSON.stringify(config, null, "\t")).to(paths.config);
		}
		s.rm(paths.lock);
		$.exit(0);
	})
.parse();

import { createWriteStream } from "node:fs";
async function download(value, onprogress, target){
	const { repository, glare }= value.local;
	const { tag_name }= value.remote;
	if(!glare) return Promise.reject({ err: "Missing 'glare' in config.", ...value });
	
	const response= await fetch(url_download+repository+`@${tag_name}/${glare}`);
	const buffer= Buffer.from(await response.arrayBuffer());
	const downloads= target+value.local.file_name;
	const ws= createWriteStream(downloads, { flags: "w" });
	ws.write(buffer);
	Object.assign(value.local, {
		last_update: value.remote.published_at,
		version: value.remote.tag_name,
		downloads
	});
	if(value.local.exec==="yes")
		s.chmod("+x", downloads);
	onprogress();
	return value;
}

function grepPackages({ packages }, { group, repository, api, verbose }){
	if(api && api!==url_api && urls_api.hasOwnProperty(api))
		url_api= api;
	if(verbose)
		echo(`Using API: ${url_api} (${urls_api[url_api]})`);
	const f= {};
	let is_filter= false;
	if(group){ is_filter= true; f.group= group; }
	if(repository){ is_filter= true; f.repository= repository; }
	if(verbose)
		echo("Filter:", f);
	if(!is_filter) return packages;
	return packages.filter(r=> Object.keys(f).every(k=> r[k]===f[k]));
}
function echoPkgStatus(status, { local, remote }){
	let status_css, status_text;
	if(local.group && local.group.includes("skip")){
		status_text= "skipped";
		status_css= "skip";
	} else {
		status_text= status===3 ? "outdated" : "up-to-date";
		status_css= status===3 ? "err" : "ok";
	}
	echo((status_text==="outdated" ? "+" : "-") + " %c"+local.repository + "%c: %c"+status_text+"%c (%c"+remote.tag_name+"%c)",
		css.pkg, css.unset, css[status_css], css.unset, css.skip, css.unset);
}
/**
 * @param {Config.packages} packages
 * @return {Promise<{ status: 0|1|2|3, value: { remote: GitHubRelease, local: ConfigPackage } }>}
 * */
async function check(packages, cache){
	return (await pipe(
		ps=> ps.map(p=> fetchRelease(p, cache).then(remote=> ({ local: p, remote }))),
		ps=> Promise.allSettled(ps)
	)(packages))
		.map(({ status, ...v })=> status==="rejected" ?
			{ status: -1, value: v } :
			{ status: packageStatus(v.value.local, v.value.remote), value: v.value })
		.filter(({ status, value })=> {
			if(status!==-1) return true;
			echo("%c"+value.reason, css.err);
			
		});
}
/** @type {(local: ConfigPackage, remote: GitHubRelease)=> 0|1|2|3} */
function packageStatus({ last_update: local }, { published_at: remote }){
    if(!remote) return 0;
    if(!local) return 3;
    if(remote===local) return 1;
    return 2+(local<remote);
}
/** @param {ConfigPackage} package */
async function fetchRelease({ repository, tag_name_regex }, cache){
	const headers= { 'User-Agent': 'node' };
	if(cache==="no") headers['Cache-Control'] = 'no-cache';
	const url= urls_api[url_api]+repository+"/releases";
	const releases= await fetch(url, { headers }).then(res=> res.json());
	if(releases.message) return $.error(url+": "+releases.message);

	if(url.includes("github.com"))
		return releases.find(function ({ draft, published_at, tag_name }){
			if(draft||!published_at) return false;
			if(!tag_name_regex) return true;
			return (new RegExp(tag_name_regex, 'g')).test(tag_name);
		});
	
	const { draft, publishedAt, tag }= releases.releases.find(function ({ draft, publishedAt, tag }){
		if(draft||!publishedAt) return false;
		if(!tag_name_regex) return true;
		return (new RegExp(tag_name_regex, 'g')).test(tag);
	});
	return { draft, published_at: publishedAt, tag_name: tag };
}

function readConfig(){
	if(!s.test("-f", paths.config)) return { packages: [] };
	const out= Object.assign({ target: "~/bin/" },
		s.cat(paths.config).xargs(JSON.parse));
	if(out.target.startsWith("~/")) out.target= $.xdg.home(out.target.slice(2));
	return out;
}
