'use strict';

var Parser = require('./ex2.js').Parser;
var lexer = new Parser().lexer;

lexer.setInput('Hello, the ALF TP is from 12 PM to 2 PM.');

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
       console.log (s + ' ' + lexer.yytext);
       tokens.push ({type: s, value: lexer.yytext});
   }
} while (s !== lexer.EOF);

console.log (tokens);