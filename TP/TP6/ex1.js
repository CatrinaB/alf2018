"use strict";

var parser = require ('./variable.js').parser;

try {
   console.log(JSON.stringify(parser.parse ('var a, b; 2 + 3 * 5;'), null, 2));
}
catch (e) {
   console.log (e.message);
   console.log (e.hash);
}