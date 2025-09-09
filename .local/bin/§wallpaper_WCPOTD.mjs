#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
const img_params= "?width=1920";
const url_api= "https://commons.wikimedia.org/w/api.php";
const url_image= "https://commons.wikimedia.org/wiki/Special:FilePath/";

import { join } from "node:path";
const path_home= $.xdg.home`Obrázky/Bing Image Of The Day/`;
const path_info= join(path_home, "images.json");

$.api()
.version("2025-04-02")
.command("pull", "Pull new/today image(s)")
.action(async function pull(){
	const images= {
		now: await getImagePath(0),
		prev: await getImagePath(-1)
	};
	const paths= await downloadImages(images);
	updateHTML(images);
	const images_save= Object.entries(images)
		.reduce((acc, [ key, { caption } ])=>
			Reflect.set(acc, key, caption) && acc,
	{});
	convert(paths, images_save);
	s.echo(JSON.stringify(images_save, null, "\t")).to(path_info);
	newPanel(images_save.now);
	$.exit(0);
})
.command("redraw")
.action(function redraw(){
	const paths= [ "now", "prev" ].map(key=> join(path_home, `${key}.jpg`));
	const images= s.cat(path_info).xargs(JSON.parse);
	convert(paths, images);
	newPanel(images.now);
	$.exit(0);
})
.command("status")
.action(function status(){
	const images= s.cat(path_info).xargs(JSON.parse);
	const [ stats ]= s.ls("-l", path_info);
	echo({ timestamp: stats.mtime, ...images });
	$.exit(0);
})
.parse();
function newPanel(caption){
	const link= `<a href="https://commons.wikimedia.org/wiki/Template:Potd/${dateISO(0)} (cs)">(i)</a>`;
	s.sed("-i", /\<aside\>.*?\<\/aside\>/, `<aside>${link} ${caption}</aside>`, join(path_home, "Nový panel.html"));
}
/** @typedef {{ url: string, caption: string }} T_response */
/** @typedef {Record<"now"|"prev",T_response>} T_images */
/** @param {Record<"now"|"prev",string>} paths */
function convert(paths, images){
	const resize_to= "1920x1080";
	
	paths= Object.values(paths);
	const target= join(path_home, "horizontally.jpg");
	const params= `-resize ${resize_to}^ -gravity center -extent ${resize_to}`.split(" ");
	const caption= (position, text)=> [
		"convert",
		`"${target}"`,
			"\\(",
				"-pointsize", "12",
				"-background", "transparent",
				"-fill", "white",
				"-family", `"Ubuntu Mono"`,
				"-weight", "Bold",
				"-gravity", "center",
				"-bordercolor",  '"rgba(0,0,0,0.3)"',
				"-border", "10",
				"-size", "500x",
				`caption:"${text}"`,
			"\\)",
			"-gravity", position,
			"-geometry", "+0+0",
			"-composite",
		`"${target}"`,
	].join(" ");
	s.run`convert ${paths} ${params} +append ${target}`;
	s.run(caption("southwest", images.now));
	s.run(caption("southeast", images.prev));
}
import { writeFileSync } from "node:fs";
/** @param {T_images} images */
function updateHTML(images){
	let template= s.cat(join(path_home, "index_template.html")).trim();
	for(const [ key, image ] of Object.entries(images))
		template= template.replace(`::${key}::`, image.caption);
	s.echo(template).to(join(path_home, "index.html"));
}
/** @param {T_images} images */
async function downloadImages(images){
	const out= {};
	for(const [ key, image ] of Object.entries(images))
		out[key]= await downloadImage(image, key);
	return out;
}
async function getImagePath(shift= 0){
	const date= dateISO(shift);
	const { expandtemplates: { wikitext: filepath } }= await fetchGet({
		action: "expandtemplates",
		prop: "wikitext",
		text: `{{Potd/${date}}}`,
	});
	const pluckCaption= response=> response.expandtemplates.wikitext;
	const caption_fallback= await fetchGet({
		action: "expandtemplates",
		prop: "wikitext",
		text: `{{Potd/${date} (en)}}`,
	}).then(pluckCaption);
	const caption= pipe(
		pluckCaption,
		caption=> caption !== `[[:Template:Potd/${date} (cs)]]` ? caption : caption_fallback,
		caption=> caption.replace(/\[\[.*?\]\]/g, m=> m.slice(2, -2).split("|").reverse()[0]),
		caption=> caption.replace(/''(.*?)''/g, "„$1”"),
	)(await fetchGet({
		action: "expandtemplates",
		prop: "wikitext",
		text: `{{Potd/${date} (cs)}}`,
	}));
	/* TODO?
	 *	action: 'query',
	 *	prop: 'imageinfo',
	 *	iiprop: 'extmetadata',
	 *	iiextmetadatafilter: 'LicenseShortName|Artist|LicenseUrl',
	 *	titles: `Image:${ filename }`
	 *
	 *	res.data.query.pages[0].imageinfo[0].extmetadata
	 * */
	return {
		caption: caption,
		url: url_image+encodeURI(filepath)
	};
}

/** @param {T_response} image @param {"prev"|"now"} type */
async function downloadImage({ url }, type){
	const filename= join(path_home, `${type}.jpg`);
	let response= await fetch(url+img_params);
	if(response.status!==200){
		response= await fetch(url);
		if(response.status!==200)
			throw new Error(`Failed to download image: ${response.status} ${response.statusText}`);
	}
	const buffer= await response.arrayBuffer();
	writeFileSync(filename, Buffer.from(buffer));
	return filename;
}
function dateISO(shift= 0){
	const d= new Date();
	d.setDate(d.getDate()+shift);
	return d.toISOString().substring(0, 10);
}
function fetchGet(params){
	if(!params.format) params.format= "json";
	return fetch(url_api+"?"+(new URLSearchParams(params)).toString(), { method: "GET" }).then(res=> res.json());
}
