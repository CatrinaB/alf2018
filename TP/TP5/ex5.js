"use strict";

var parser = require ('./expression.js').parser;

try {
   parser.parse ('(2 + 5); % 3;');
}
catch (e) {
   console.log (e.message);
   console.log ('Unexpected ' + e.hash.token + ' on line ' + (e.hash.line + 1) + ' at position ' + e.hash.loc.first_column);
}