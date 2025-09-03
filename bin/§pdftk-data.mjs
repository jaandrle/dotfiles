#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
const tmp= "tmp-"; //pdftk has issue reading from /tmp, so need to put it somewhere to the same folder :-(
if(!s.which("pdftk")) $.error("pdftk not found");

$.api()
.version("2025-08-05")
.describe([
	"A small wrapper around 'pdftk' to extract data from pdf into the JSON.",
	"Or to update the PDF with data from JSON.",
	"Bookmars are converted to JSON object with key=PageNumber, value= Title (no. of spaces= level-1).",
])
.option("--debug", "Debug mode")
.command("extract <file_pdf> [file_info]", "Extract data from PDF.")
.action(function extract(file_pdf, file_info, { debug }){
	if(!s.test("-f", file_pdf)) $.error("PDF File not found");
	if(!file_info) file_info= filename(file_pdf) + ".json";
	
	const temp= `${tmp}${tmpname(file_pdf)}.info` ;
	s.run`pdftk ${file_pdf} dump_data_utf8 output ${temp}`;
	const info= infoToJSON(temp);
	if(!debug) s.rm(temp);
	s.echo(info).to(file_info);
	$.exit(0);
})
.command("update <file_pdf> [file_info]", "Update PDF with data from JSON.")
.action(function update(file_pdf, file_info, { debug }){
	if(!s.test("-f", file_pdf)) $.error("PDF File not found");
	if(!file_info) file_info= filename(file_pdf) + ".json";
	if(!s.test("-f", file_info)) $.error("Info File not found");
	
	const info= infoFromJSON(file_info);
	const temp= `${tmp}${tmpname(file_pdf)}.info`;
	s.echo(info).to(temp);
	const tmp_pdf= `${tmp}${tmpname(file_pdf)}.pdf`;
	s.cp(file_pdf, tmp_pdf);
	s.run`pdftk ${tmp_pdf} update_info_utf8 ${temp} output ${file_pdf}`;
	if(!debug){
		s.rm(tmp_pdf);
		s.rm(temp);
	}
	$.exit(0);
})
.command("convert <file_info>", "Converts between JSON and raw text.")
.action(function convert(file_info){
	if(!s.test("-f", file_info)) $.error("Info File not found");
	const ext= file_info.slice(file_info.lastIndexOf("."));
	const info= ext===".json" ? infoFromJSON(file_info) : infoToJSON(file_info);
	echo(info);
	$.exit(0);
})
.parse();

function filename(path){ return path.slice(path.lastIndexOf("/")+1, path.lastIndexOf(".")); }
function tmpname(path){ return filename(path) + "-" + Date.now(); }
function infoFromJSON(file_info){
	const info= s.cat(file_info).xargs(JSON.parse);
	const output= [];
	info.Bookmark= Object.entries(info.Bookmark)
		.map(/** @param {[string, string]} _ */([PageNumber, Title])=> {
			const level= Title.search(/[^ ]/);
			return {
				PageNumber,
				Title: Title.slice(level),
				Level: level+1,
			};
		});
	for(const [key, value] of Object.entries(info)){
		if(Array.isArray(value)){
			const records= value.flatMap(pipe(
				Object.entries,
				entries=> [key+"Begin"].concat(entries.map(([subkey, value])=> `${key}${subkey}: ${value}`)),
			));
			output.push(...records);
			continue;
		}
		if(typeof value==="object"){
			const records= Object.entries(value).flatMap(([subkey, value])=> [
				key+"Begin",
				`${key}Key: ${subkey}`,
				`${key}Value: ${value}`,
			]);
			output.push(...records);
			continue;
		}
		output.push(`${key}: ${value}`);
	}
	return output.join("\n");
}
/** @returns {Record<string, unknown>} */
function infoToJSON(file_info){
	const output= new Map();
	const data= s.cat(file_info).split("\n");
	let line= 0;
	const isEnd= line=> line>=data.length;
	for(; line<data.length; line++){
		const content= data[line].trim();
		if(!content) continue;
		
		if("InfoBegin"===content){
			const info= output.has("Info") ? output.get("Info") : {};
			const curr= [];
			while(++line){
				if(isEnd(line)) break;
				const content= data[line].trim();
				if(!content){ line++; continue; }
				const [key, value]= content.split(": ");
				const index= ["InfoKey", "InfoValue"].indexOf(key);
				if(index===-1){ line--; break; }
				curr[index]= value;
			}
			const [key, value]= curr;
			info[key]= value;
			output.set("Info", info);
			continue;
		}
		if(content.endsWith("Begin")){
			const name= content.replace("Begin", "");
			const output_curr= output.has(name) ? output.get(name) : [];
			const curr= {};
			while(++line){
				if(isEnd(line)) break;
				const content= data[line].trim();
				if(!content){ line++; continue; }
				const [key, value]= content.split(": ");
				if(!key.startsWith(name) || key === (name+"Begin")){ line--; break; }
				curr[key.replace(name, "")]= value;
			}
			output_curr.push(curr);
			output.set(name, output_curr);
			continue;
		}
		const [key, value]= content.split(": ");
		output.set(key, value);
	}
	output.set("Bookmark", pipe(
		items=> items.map(({ PageNumber, Title, Level })=> ([PageNumber, " ".repeat(Number(Level)-1) + Title])),
		Object.fromEntries,
	)(output.get("Bookmark") || []));
	return pipe(
		Object.fromEntries,
		o=> JSON.stringify(o, null, "\t"),
	)(output.entries());
}
