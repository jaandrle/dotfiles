#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
const url_api= "https://nocodb.jaandrle.cz/api/v1/db/data/v1/Linky/Linky";
$.api()
.command("add-md")
	.action(async function addMd(){
		const { clipboard }= $;
		const [ title, url ]= clipboard.split("](");

		const res= await fetch(url_api, {
			body: JSON.stringify({ Popis: title.slice(1), Url: url.slice(0, -1) }),
			headers: { "xc-token": "Js7Qu0oT_wTmGJDFKlIZEBhwk87WF0L1wLmQO01F",
				"accept": "application/json", "Content-Type": "application/json"
			},
			method: "post"
		}).then(res=>res.json());
		echo(res);
	})
.parse();
