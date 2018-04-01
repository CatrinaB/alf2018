"use strict";

var parser = require ('./variable.js').parser;

try {
   console.log(JSON.stringify(parser.parse ('print (a, 2.5, 40*5/2);'), null, 2));
}
catch (e) {
   console.log (e.message);
   console.log (e.hash);
}