#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
$.is_fatal= true;
const root= "~/.config/coc/ultisnips/";
const files= Object.fromEntries( s.ls(root).map(fn=> [fn, s.cat(root+fn).trim()]) );
Object.keys(files).forEach(fn=> {
	const file= files[fn];
	if(!file.startsWith("extends ")) return;
	const lines= file.split("\n"); 
	const line_end= pipe( id=> id===-1 ? lines.length : id )( lines.findIndex(l=> l.startsWith("#endextends")) );
	const include= lines[0].replace("extends ", "").trim().split(/, ?/g).map(s=> files[s+".snippets"]).join("\n");
	lines.splice(1, line_end-1, include);
	s.echo(lines.join("\n").trim()).to(root+fn);
})
