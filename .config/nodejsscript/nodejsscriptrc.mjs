/* --print/--echo aliases */
Reflect.defineProperty($, "nosed", { get(){ return this.stdin.text(""); }, });
Reflect.defineProperty($, "nojq", { get(){ return this.stdin.json(null); }, });
Reflect.defineProperty($, "noawk", { get(){ return this.stdin.lines([]); }, });

/* deprecated/fallback */
globalThis.cyclicLoop= function*(items){
	if(!items) items= 'win32'===process.platform ? '|/-\\' : "⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏";
	const { length }= items;
	for(let i=0; true; i++){
		if(i===length) i= 0;
		yield items[i];
	}
}

Reflect.defineProperty($, "clipboard", {
	get(){ return s.$().run`xclip -o -selection clipboard`; }
})
