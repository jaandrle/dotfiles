#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
const css= echo.css`
	.error{ color: lightred; }
	.code, .method{ color: lightblue; }
	.code::before, .code::after{ content: "\`"; }
	.li{ padding-left: 2ch; }
`;
const cmd= "qdbus";
if(!s.which(cmd))
	$.exit(1, echo([
		`%cError: ${cmd} not found.`,
		`%cInstall it with: %csudo apt install ${cmd}`,
	].join("\n"), css.error, css.unset, css.code));

import { EventEmitter } from "node:events";
const events= new EventEmitter();
const exit_event= "exit";
events.on(exit_event, $.exit);

$.api("", true)
.version("2024-03-05")
.describe([
	`KWallet CLI using ${cmd}.`,
	"Call with no arguments to list all methods.",
])
.example("--wallet kdewallet folderList")
.example("--wallet kdewallet readPassword folder entry")
.option("--wallet, -w", "Wallet name", "kdewallet")
.action(function({ _, wallet }){
	const qdbus= qdbusGenerator({
		service: "org.kde.kwalletd6",
		methods: "/modules/kwalletd6",
		wallet,
		exit_event
	});
	if(!_.length)
		echoLs(qdbus());
	else{
		//TODO: Map (`--literal` in qdbus and decode the result `echoMap`)
		const result= qdbus(_);
		echo(result);
	}
	events.emit(exit_event);
})
.parse();

function qdbusGenerator({ service, methods, wallet, exit_event }){
	const name= getScriptName();
	const no_id= [
		'allWalletsClosed',
		'applicationDisconnected',
		'folderListUpdated',
		'folderUpdated',
		'walletClosed',
		'walletCreated',
		'walletDeleted',
		'walletListDirty',
		'walletOpened',
		'changePassword',
		'close',
		'closeAllWallets',
		'deleteWallet',
		'disconnectApplication',
		'folderDoesNotExist',
		'isEnabled',
		'isOpen',
		'keyDoesNotExist',
		'localWallet',
		'networkWallet',
		'open',
		'openAsync',
		'openPath',
		'openPathAsync',
		'pamOpen',
		'reconfigure',
		'users',
		'wallets'
	];

	let id;
	const qdbus= (...args)=> s.$().run`${cmd} ${service} ${methods} ${args}`;
	events.on(exit_event, ()=>{
		if(!id) return;
		qdbus("close", id, false, name);
		id= null;
	});
	return function([ method, ...args ]= []){
		if(!method) return qdbus();
		if(no_id.includes(method)) return qdbus(method, ...args);
		if(!id) open();
		return qdbus(method, id, ...args, name);
	};
	function open(){
		id= qdbus("open", wallet, 0, name).trim();
		return id;
	}
}
function echoMap(map){
	map= map.slice(1, -1).split(", ").map(n=> Number.parseInt(n));
	const ab= new ArrayBuffer(map.length);
	const view= new Uint8Array(ab);
	for(let i= 0; i<map.length; i++)
		view[i]= map[i];

	const words= [];
	for(let i= 0; i<map.length; i+= 4){
		words.push(String.fromCharCode.apply(null, view.subarray(i, i+4)));
	}
	pipe(
		echo
	)(words);
}
function echoLs(list){
	const ns= "org.kde.KWallet.";
	pipe(
		list=> list.split("\n").filter(l=> l.startsWith("method") && -1!==l.indexOf(ns)),
		list=> list.map(l=> l.slice(l.indexOf(" ")+1)).map(l=> l.replace(ns, "")),
		list=> list.reduce((o, l)=> (o[Number(l.indexOf("int handle")!==-1)].push(l), o), [ [], [] ]),
		([ no_wallet, wallet ])=> [
			"Methods available without wallet:",
			...no_wallet.map(formatMethod),
			"Methods available with wallet (" + echo.format("%c--wallet", css.code) + " option):",
			...wallet.map(formatMethod)
		].join("\n"),
		echo
	)(list);
	function formatMethod(line){
		const ch_type= line.indexOf(" ")+1;
		const ch_name= line.indexOf("(", ch_type);
		return echo.format([
			"",
			line.slice(0, ch_type),
			line.slice(ch_type, ch_name),
			line.slice(ch_name)
		].join("%c"), css.li, css.method, css.unset);
	}
}
function getScriptName(){
	const { url }= import.meta;
	return (new URL(url)).href.slice((new URL("./", url).href.length));
}
