[styling=C]
[keywords]
primary=abstract await boolean break byte case catch char class const continue debugger default delete do double else enum export extends false final finally float for function goto if implements import in instanceof int interface let long native new null package private protected public return short static super switch synchronized this throw throws transient true try typeof var void volatile while with yield
secondary=Array ArrayBuffer Boolean DataView Date decodeURI decodeURIComponent encodeURI encodeURIComponent Error eval EvalError Float32Array Float64Array Function hasOwnProperty Infinity Int16Array Int32Array Int8Array isFinite isNaN isPrototypeOf JSON Map Math NaN Number Object parseFloat parseInt Promise propertyIsEnumerable Proxy RangeError ReferenceError Reflect RegExp Set String Symbol SyntaxError toLocaleString toString TypeError Uint16Array Uint32Array Uint8Array Uint8ClampedArray undefined URIError valueOf WeakMap WeakSet

[lexer_properties=C]
#~ # partially handles ES6 template strings
lexer.cpp.backquoted.strings=1

[settings]
extension=js
#~ lexer_filetype=C
lexer_filetype=ActionScript
mime_type=text/x-typescript
wordchars=$_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
comment_single=//
comment_open=/*
comment_close=*/
comment_use_indent=true