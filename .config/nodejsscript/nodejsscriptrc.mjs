Reflect.defineProperty($, "clipboard", {
	get(){
		if($.env.XDG_SESSION_TYPE === "x11")
			return s.$().run`xclip -o -selection clipboard`;
		return s.$().run`wl-paste`;
	}
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
// export function oneval(){}
