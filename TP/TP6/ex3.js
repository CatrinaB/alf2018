"use strict";

var parser = require ('./variable.js').parser;

try {
   console.log(JSON.stringify(parser.parse ('a = 2 * 7 + 14;'), null, 2));
}
catch (e) {
   console.log (e.message);
   console.log (e.hash);
}