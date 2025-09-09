#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */

const pathLastDesktop= ()=> $.xdg.temp`kde6-workarounds-last-desktop.txt`;
const css= echo.css`
	.code { color: gray; }
`;

$.api()
.version("2024-02-29")
.describe("Workarounds for KDE6.")
.command("logout")
.action(function(){
	$.is_silent= true;
	const res= s.run([
		"echo ::options::",
		"|",
		"rofi -dmenu -p 'Logout' -l 4 -theme-str 'window { width: 25ch; }' -normal-window"
	].join(" "), {
		options: [ "-", "poweroff", "reboot" ].join("\n")
	}).trim();
	if(res && res!=="-") s.run(res);
	$.exit(0);
})
.command("klipper-edit", "Edit last item in klipper.")
.action(async function(){
	$.is_silent= true;
	const qdbus= "qdbus org.kde.klipper /klipper org.kde.klipper.klipper.";
	try{
		const candidate= s.run(`${qdbus}getClipboardContents`).trim();
		const content= await $.read({ "-p": "Edit", completions: [ candidate ] });
		s.run(`${qdbus}setClipboardContents "${content}"`);
		$.exit(0);
	} catch (_){
		$.exit(1);
	}
})
.command("desktops-alttab", "Workaround for KDE6 alt-tab between virtual desktops.")
.action(function(){
	const path= pathLastDesktop();
	// Regarding ★ : this is a workaround for diagonal switching (it duplicates desktop index)
	let desktop= s.cat(path).trim() || "1";
	if(desktop.length>3){ // ★
		const [ _1, _2, ..._3 ]= desktop.slice(-4, desktop.length);
		if(_1===_2)
			desktop= desktop.slice(0, -4).concat(_1, ..._3);
	}
	if(desktop.length>2){ // ★
		const [ _1, _2 ]= desktop.slice(-2, desktop.length);
		if(_1===_2)
			desktop= desktop.slice(0, -1);
	}
	if(desktop.length>2){
		desktop= desktop.slice(-2, desktop.length);
		s.echo(desktop).to(path);
	}
	echo(desktop);
	s.run`qdbus org.kde.KWin /KWin org.kde.KWin.setCurrentDesktop ${desktop[0]}`;
	$.exit(0);
})
.command("desktops-last-dbus")
.action(function(){
	echo([
		"dbus-monitor",
		'"interface=org.kde.KWin.VirtualDesktopManager" "member=currentChanged"',
		"|",
		'xargs -e -I {} kde6-workarounds.mjs desktops-last-save {}'
	].join(" "));
	$.exit(0);
})
.command("desktops-last-save <dbus>", "Workaround for KDE6 alt-tab between virtual desktops.")
.action(function(dbus){
	if(-1===dbus.indexOf("path=/VirtualDesktopManager; interface=org.kde.KWin.VirtualDesktopManager; member=currentChanged"))
		return $.exit(1);
	const desktop= s.run`qdbus org.kde.KWin /KWin org.kde.KWin.currentDesktop`.trim();
	s.echo(desktop).toEnd(pathLastDesktop());
})
.parse();
