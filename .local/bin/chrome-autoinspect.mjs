#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
const css= echo.css`
	.url{ color: lightblue; }
	.code { font-style: italic; }
	.code::before, .code::after { content: "\`"; }
`;
$.api()
	.version("2023-03-23")
	.describe([
		echo.format("This is small utility around %cchrome-remote-interface%c¹ to auto open inspect for cordova apps.", css.code),
		echo.format("[1] %chttps://github.com/cyrus-and/chrome-remote-interface", css.url)
	])
	.command("open", "This open browser and after 30secs enable auto inspect openning.", true)
	.option("--browser, -B", "Browser exec. Use one of supported browsers, such as chrome, chromium, opera, edge, …", "chromium")
	.option("--port, -P", "Chanhe debugging port", 9222)
	.action(async function({ browser, port }){
		s.runA`${browser} --remote-debugging-port=${port}`;
		const { setTimeout }= await import("node:timers/promises");
		await setTimeout(30_000);
		await register();
		$.exit(0);
	})
	.command("enable", "Enable auto inspect openning for already running browser.")
	.action(async function(){
		await register();
		$.exit(0);
	})
	.parse();

async function register(){
	const { default: CDP } = await import($.xdg.globalPackage`chrome-remote-interface`);
	let client;
	try{
		await CDP.New();
		client= await CDP();
		const { Network, Page, Runtime }= client;
		await Network.enable();
		await Page.enable();
		await Page.navigate({url: 'chrome://inspect/#devices'});
		await Page.loadEventFired();
		await Runtime.evaluate({ expression: `const debugCordova= (${autoRunCordovaAppInspect.toString()})();` });
	} finally {
		if(!client) return;
		return await client.close();
	}
}

function autoRunCordovaAppInspect(){
	const { filter, map }= Array.prototype;
	let /* filters */
		device_filter, app_filter, last_state;
	const /* get elements */
		devicesElements= ()=> filter.call(document.getElementsByClassName("device"), el=> el.id!=="device:localhost"),
		getApp= el=> el.getElementsByClassName("browser-name")[0].textContent,
		appTest= browser_candidate_el=> getApp(browser_candidate_el).indexOf(app_filter)!==-1,
		browsersElements= wrapper_el=> wrapper_el.getElementsByClassName("browser"),
		actionElementFilter= wrapper_el=> filter.call(wrapper_el.getElementsByClassName("action"), el=> el.textContent==="inspect")[0];

	function run(){
		const device= !device_filter ? (d=> d&&d[d.length-1])(devicesElements()) : filter.call(devicesElements(), el=> el.id===device_filter)[0];
		if(!device) return false;
		const app= !app_filter ? (a=> a&&a[a.length-1])(browsersElements(device)) : filter.call(browsersElements(document), appTest)[0];
		if(!app) return false;
		const { id }= app;
		if(last_state===id) return false;
		last_state= id;
		const action= actionElementFilter(app);
		if(!action) return false;
		action.click();
	}
	const observer= new MutationObserver(run);
	observer.observe(document.getElementById("devices-list"), { childList: true, subtree: true })
	return {
		/* Set string to filter, typically app id or ip */
		setApp: _app_filter=> app_filter= _app_filter,
		/* Apply only for given device (see debugCordova.devices). */
		setDevice: _device_filter=> device_filter= _device_filter,
		get apps(){ return map.call(browsersElements(document), getApp); },
		get devices(){ return map.call(devicesElements(), el=> el.id); }
	};
}
