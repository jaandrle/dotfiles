#!/usr/bin/env nodejsscript
/* jshint esversion: 11,-W097, -W040, module: true, node: true, expr: true, undef: true *//* global echo, $, pipe, s, fetch, cyclicLoop */
const systems= {
	/**
	 * From https://en.wikipedia.org/wiki/Ubuntu_version_history
	 * @type {{ubuntu: string, codename: string, is_lts: boolean}[]}
	 * */
	ubuntu: JSON.parse(`[
		{
			"ubuntu": "4.10",
			"codename": "Warty Warthog",
			"is_lts": false
		},
		{
			"ubuntu": "5.04",
			"codename": "Hoary Hedgehog",
			"is_lts": false
		},
		{
			"ubuntu": "5.10",
			"codename": "Breezy Badger",
			"is_lts": false
		},
		{
			"ubuntu": "6.06",
			"codename": "Dapper Drake",
			"is_lts": true
		},
		{
			"ubuntu": "6.10",
			"codename": "Edgy Eft",
			"is_lts": false
		},
		{
			"ubuntu": "7.04",
			"codename": "Feisty Fawn",
			"is_lts": false
		},
		{
			"ubuntu": "7.10",
			"codename": "Gutsy Gibbon",
			"is_lts": false
		},
		{
			"ubuntu": "8.04",
			"codename": "Hardy Heron",
			"is_lts": true
		},
		{
			"ubuntu": "8.10",
			"codename": "Intrepid Ibex",
			"is_lts": false
		},
		{
			"ubuntu": "9.04",
			"codename": "Jaunty Jackalope",
			"is_lts": false
		},
		{
			"ubuntu": "9.10",
			"codename": "Karmic Koala",
			"is_lts": false
		},
		{
			"ubuntu": "10.04",
			"codename": "Lucid Lynx",
			"is_lts": true
		},
		{
			"ubuntu": "10.10",
			"codename": "Maverick Meerkat",
			"is_lts": false
		},
		{
			"ubuntu": "11.04",
			"codename": "Natty Narwhal",
			"is_lts": false
		},
		{
			"ubuntu": "11.10",
			"codename": "Oneiric Ocelot",
			"is_lts": false
		},
		{
			"ubuntu": "12.04",
			"codename": "Precise Pangolin",
			"is_lts": true
		},
		{
			"ubuntu": "12.10",
			"codename": "Quantal Quetzal",
			"is_lts": false
		},
		{
			"ubuntu": "13.04",
			"codename": "Raring Ringtail",
			"is_lts": false
		},
		{
			"ubuntu": "13.10",
			"codename": "Saucy Salamander",
			"is_lts": false
		},
		{
			"ubuntu": "14.04",
			"codename": "Trusty Tahr",
			"is_lts": true
		},
		{
			"ubuntu": "14.10",
			"codename": "Utopic Unicorn",
			"is_lts": false
		},
		{
			"ubuntu": "15.04",
			"codename": "Vivid Vervet",
			"is_lts": false
		},
		{
			"ubuntu": "15.10",
			"codename": "Wily Werewolf",
			"is_lts": false
		},
		{
			"ubuntu": "16.04",
			"codename": "Xenial Xerus",
			"is_lts": true
		},
		{
			"ubuntu": "16.10",
			"codename": "Yakkety Yak",
			"is_lts": false
		},
		{
			"ubuntu": "17.04",
			"codename": "Zesty Zapus",
			"is_lts": false
		},
		{
			"ubuntu": "17.10",
			"codename": "Artful Aardvark",
			"is_lts": false
		},
		{
			"ubuntu": "18.04",
			"codename": "Bionic Beaver",
			"is_lts": true
		},
		{
			"ubuntu": "18.10",
			"codename": "Cosmic Cuttlefish",
			"is_lts": false
		},
		{
			"ubuntu": "19.04",
			"codename": "Disco Dingo",
			"is_lts": false
		},
		{
			"ubuntu": "19.10",
			"codename": "Eoan Ermine",
			"is_lts": false
		},
		{
			"ubuntu": "20.04",
			"codename": "Focal Fossa",
			"is_lts": true
		},
		{
			"ubuntu": "20.10",
			"codename": "Groovy Gorilla",
			"is_lts": false
		},
		{
			"ubuntu": "21.04",
			"codename": "Hirsute Hippo",
			"is_lts": false
		},
		{
			"ubuntu": "21.10",
			"codename": "Impish Indri",
			"is_lts": false
		},
		{
			"ubuntu": "22.04",
			"codename": "Jammy Jellyfish",
			"is_lts": true
		},
		{
			"ubuntu": "22.10",
			"codename": "Kinetic Kudu",
			"is_lts": false
		},
		{
			"ubuntu": "23.04",
			"codename": "Lunar Lobster",
			"is_lts": false
		},
		{
			"ubuntu": "23.10",
			"codename": "Mantic Minotaur",
			"is_lts": false
		},
		{
			"ubuntu": "24.04",
			"codename": "Noble Numbat",
			"is_lts": true
		},
		{
			"ubuntu": "24.10",
			"codename": "Oracular Oriole",
			"is_lts": false
		}
	]`)
};

$.api()
.version("2024-08-15")
.option("--system", "System", "ubuntu")
.command("codename <current>")
.option("--shift", "Shift", 0)
.action(function(current, { system, shift }){
	const unify= s=> s.toLowerCase().replace(/[^a-z]/g, "");
	current= unify(current);
	system= systems[system];
	const idx= system.findIndex(s=> unify(s.codename)===current);
	if(idx=== -1) return $.exit(1);
	const out= system[(idx+shift)%system.length];
	echo($.isFIFO(1) ? JSON.stringify(out) : out);
	$.exit(0);
})
.parse();
