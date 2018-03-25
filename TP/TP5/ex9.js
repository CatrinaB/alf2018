"use strict";

var fs = require('fs');
var parser = require ('./expression.js').parser;

try {
    parser.parse ('int i <- 7.5 / 3; double d <- 9 / 4; boolean b <- true && !false || false; string s <- "a" + "b";');
}
catch (e) {
    console.log (e.message);
    console.log (e.hash);
}