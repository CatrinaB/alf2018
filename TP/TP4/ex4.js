'use strict';

var fs = require('fs');
var Parser = require('./ex2.js').Parser;
var lexer = new Parser().lexer;

var data = fs.readFileSync('text_and_numbers.txt').toString();
lexer.setInput(data);

var s = null;
var tokens = [];

do 
{
   try
   {
       s = lexer.next();
   }
   catch (e)
   {
       console.log ('Error line ' + (lexer.yylineno + 1) + '\n' + lexer.showPosition());
   }
   if (s && s!== lexer.EOF)
   {
       tokens.push ({type: s, value: lexer.yytext});
   }
} while (s !== lexer.EOF);

console.log (tokens);