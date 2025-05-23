#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */

$.api("")
.version("2024-09-05")
.command("silicon <file>", [
	"Generovat obrázek s kódem pro sdílení na sociálních sítích. (alternativa k Carbon)",
	"Toto je jen drobný wrapper s mými defaultními parametry.",
	"Další nápověda viz `silicon --help`.",
])
	.option("--title", "Set window title (default: file name).")
	.option("--range", "Select lines from file in the form `start:end`")
	.option("--font-size, --fs", "Font size", 25)
	.action(function silicon(file, { title= file, range, fs, ["font-size"]: _fs, _, ...args }){
		args= Object.assign({
			theme: "OneHalfDark",
			font: `Ubuntu Mono =${fs}`,
			background: "#f06d78",
			["shadow-blur-radius"]: 30,
			["tab-width"]: 2
		}, args);
		args= Object.keys(args).flatMap(key=> [ "--"+key, args[key] ]);
		let from= file;
		const index_ext= file.lastIndexOf(".");
		const output= !file ? "silicon.png" : file.slice(0, index_ext+1)+"png";
		if(range && typeof range=== "string" && range.includes(":")){
			from= $.xdg.temp`silicon-range${file.slice(index_ext)}`;
			const content= s.$().cat(file).toString().split(/\r?\n/).slice(...range.split(":").map(n=> parseInt(n)+1));
			s.echo(content.join("\n")).to(from);
		}
		s.run`silicon ${from} --output ${output} --window-title ${title} ${args}`;
		echo(`Generated ${output}`);
		if(from!== file) s.rm(from);
		$.exit(0);
	})
.command("textInImage [file]", "Generovat obrázek s textem pro sdílení na sociálních sítích.")
	.alias("tii")
	.option("--pointsize", "Text size", "62")
	.option("--gravity", "`convert -list gravity`", "Center")
	.option("--text", "Text")
	.action(textInImage)
.command("textSplit <file>", "Rozdělit text dle zadaného limitu.")
	.alias("ts")
	.option("--limit", "Počet znaků kde text rozdělovat.", 500)
	.option("--counter", "Prepend counter, set no. of chars of counter.", 5)
	.option("--text", "Text")
	.action(textSplit)
.parse();

function textSplit(file, { limit, counter, text }){
	limit= parseInt(limit) - parseInt(counter);
	const words= getText(file, text).split(" ");
	let buffer= [], i= -1, chars= limit;
	for(const word of words){
		const { length }= word;
		if((chars+length) < limit){
			chars+= ( is_empty ? 0 : 1 ) + length;
			buffer[i].end= i;
			continue;
		}
		chars= 0;
		i+= 1;
		buffer[i]= { start: i };
	}
	const { length }= buffer;
	echo(buffer.map(function({ start, end }, i){
		return (i+1)+"/"+length+" "+words.slice(start, end).join(" ");
	}).join("\n============\n"));
	$.exit(0);
}
function textInImage(file, { text, gravity, pointsize }){
	text= getText(file, text);
	const output= !file ? "textInImage.png" : (({ pathname: p })=> p.slice(1, p.lastIndexOf(".")+1)+"png")(new URL(file, "file://"));
	if(s.test("-f", output)) s.rm(output);
	const round_corners= [ //https://9to5answer.com/rounding-corners-of-pictures-with-imagemagick
		"\\(",
			"+clone  -alpha extract",
			"-draw 'fill black polygon 0,0 0,15 15,0 fill white circle 15,15 15,0'",
			"\\( +clone -flip \\) -compose Multiply -composite",
			"\\( +clone -flop \\) -compose Multiply -composite",
		"\\) -alpha off -compose CopyOpacity -composite",
	].join(" ");
	s.run([
		"convert",
		"\\(",
			"-size ::size::",
			"-pointsize ::pointsize::",
			"-fill ::fill:: -background ::background::",
			"-gravity ::gravity::",
			"-family ::family:: -weight Bold",
			"-bordercolor ::background:: -border 5%",
			"caption:::text::",
		"\\)",
		round_corners,
		"::output::"
	].join(" "), {
		fill: "whitesmoke",
		background: "#2b2b2b",
		size: "1024x512",
		family: "Ubuntu Mono",
		output, text, gravity, pointsize
	});
	$.exit(0);
}
function getText(file, text){
	if(file && s.test("-f", file))
		return s.cat(file).toString();
	if(!text)
		return $.stdin.text().trim();
	return text;
}
