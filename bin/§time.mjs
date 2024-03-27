#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
const units= {
	second: 1000,
	get minute(){ return this.second*60; },
	get hour(){ return this.minute*60; },
	get day(){ return this.hour*24; },
	get month(){ return this.day*30; },
	get year(){ return this.day*365; }
};

$.api()
.version("2024-03-27")
.command("diff <time>", [
	"Returns remaining time diff <time>.",
	"The <time> is argument to bash `date -d <time> +%s`."
])
.alias("?")
.option("--unit", "Unit, use one of the: "+Object.keys(units).join(", "))
.action(diff)
.command("zone [time]", "Returns times in different time zones.")
.option("-z", "Use multiple times to see time in different time zones.")
.action(zone)
.parse();

function diff(given, { unit }){
	const date_now= new Date();
	const date_given= new Date(s.$().run`date -d ${given} +%Y-%m-%dT%H:%M:%S%z`.trim());
	if(date_given.toLocaleString() === "Invalid Date")
		return $.exit(1, echo(date_given));

	const rtf= new Intl.RelativeTimeFormat();
	let future= 1;
	let diff= date_given - date_now;
	if(diff < 0){
		future= -1;
		diff= -diff;
	}
	if(unit){
		if(unit.endsWith("s")) unit= unit.slice(0, -1);
		echo(rtf.format(future*Math.floor(diff/units[unit]), unit));
		$.exit(0);
	}
	diff= echoUnit(future, diff, "year", rtf);
	diff= echoUnit(future, diff, "month", rtf);
	diff= echoUnit(future, diff, "day", rtf);
	diff= echoUnit(future, diff, "hour", rtf);
	diff= echoUnit(future, diff, "minute", rtf);
	diff= echoUnit(future, diff, "second", rtf);
	$.exit(0);
}
function zone(time, { z: zones }){
	if(!Array.isArray(zones)) zones= zones ? [ zones ] : [];
	if(!zones.length)
		return $.error("Please specify at least one zone.");
	
	const date_given= time ? new Date(s.$().run`date -d ${time} +%Y-%m-%dT%H:%M:%S%z`.trim()) : new Date();
	if(date_given.toLocaleString() === "Invalid Date")
		return $.error(date_given);
	
	const max_length= Math.max(...zones.map(zone=> zone.length));
	const dtf= timeZone=> new Intl.DateTimeFormat(undefined, { timeZone, dateStyle: "full", timeStyle: "long", hour12: false });
	for(const zone of zones)
		echo(zone.padStart(max_length, " "), "—", dtf(zone).format(date_given));

	$.exit(0);
}

/**
 * @param {1|-1} future
 * @param {number} num
 * @param {'year'|'month'|'day'|'hour'|'minute'|'second'} unit
 * @param {string} rtf
 * */
function echoUnit(future, num, unit, rtf){
	if(num <= units[unit]) return num;
	
	echo(rtf.format(future*Math.floor(num/units[unit]), unit));
	return num%units[unit];
}
