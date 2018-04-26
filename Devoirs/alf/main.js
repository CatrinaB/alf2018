'use strict';

var fs = require('fs');
var parser = require('./grammar.js').parser;
var exp = fs.readFileSync(process.argv[2], 'UTF-8');
var wstream;

if(process.argv.length === 4){
	wstream = fs.createWriteStream(process.argv[3], "UTF-8");
}
else{
	wstream = fs.createWriteStream(process.argv[2] + ".json", "UTF-8");
}

class SyntaxError extends Error {
	constructor(message, hash) {
    	super(message);
    	this.name = 'SyntaxError';
    	this.hash = {
    					error: 'syntax',
    					line: parseInt(hash.line) + 1,
    					text: hash.text,
    					token: hash.token,
    					expected: hash.expected
    				};
  	}
}

class LexicalError extends Error {
	constructor(message, hash) {
    	super(message);
    	this.name = 'LexicalError';
    	this.hash = {
    					error: 'lexical',
    					line: parseInt(hash.line) + 1,
    					text: message
    				};
  	}
}

try {
    var tree = parser.parse(exp);
    wstream.write(JSON.stringify(tree, null, 2));
} catch(e){
    if(e.message.includes('Syntax') || e.message.includes('Parse')){
        var syntaxE = new SyntaxError(e.message, e.hash);
        wstream.write(JSON.stringify(syntaxE.hash, null, 2));
    }
    else {
        var lexicalE = new LexicalError(e.message, e.hash);
		wstream.write(JSON.stringify(lexicalE.hash, null, 2));
    }
}