"use strict";

var parser = require ('./program.js').parser;
var fs = require ('fs');

try {
    var data = fs.readFileSync('ex4.txt').toString();
    console.log(JSON.stringify(parser.parse (data), null, 2));
}
catch (e) {
    console.log (e.message);
    console.log (e.hash);
}