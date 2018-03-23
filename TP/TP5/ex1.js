"use strict";

var parser = require ('./expression.js').parser;

try {
   parser.parse ('int a <- 2;');
}
catch (e) {
   console.log (e.message);
   console.log (e.hash);
}