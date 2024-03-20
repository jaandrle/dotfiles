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

// /** Custom uncaughtException function */
// export const uncaughtException= console.log;
// /** Place for custom code when script starts */
// export function onscript(){}
/** Place for custom code when REPL starts (`--interactive`) */
export function onrepl(){
	Reflect.defineProperty(s, "jq", { get(){ return file=> s.cat(file).xargs(JSON.parse); } });
}
/** Place for custom code when eval starts (`--eval`/`--print`) */
export function oneval(){ /* --print/--echo aliases */
	Reflect.defineProperty($, "nosed", { get(){ return this.stdin.text(""); }, });
	Reflect.defineProperty($, "nojq", { get(){ return this.stdin.json(null); }, });
	Reflect.defineProperty($, "noawk", { get(){ return this.stdin.lines([]); }, });
}
