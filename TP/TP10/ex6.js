"use strict";

// import fs for reading 
var fs = require('fs');

// import the generated Parser
var parser = require('./program.js').parser;

var str = fs.readFileSync(process.argv[2], 'UTF-8');

var variable_id = 0;

function nextVariable() {
    return 'variable' + variable_id++;
}

function writeThreeAddressCode(node) {

    if (node.type === 'script') {

        for (var statementIndex in node.statements) {
            writeThreeAddressCode(node.statements[statementIndex]);
        }

    } else if (node.type === 'expr') {

        if (node.left !== undefined && node.right !== undefined) {          
            writeThreeAddressCode(node.left);
            writeThreeAddressCode(node.right);
            // node.left is the result of node.left
            // node.right is the result of node.right
            // write the three address code here
            if (node.op === '+') {
                console.log('add');
            } else if (node.op === '-') {
                console.log('sub');
            } else if (node.op === '*') {
                console.log('mul');
            } else if (node.op === '/') {
                console.log('div');
            }
        }
    } else if (node.type === 'number') {
        // the result for a number is the number itself
        console.log('push ' + node.value);
    
    } else if (node.type === 'id') {

        console.log('push ' + node.value);
    
    } else if (node.type === 'function_run') {

        for (let i = 0; i < node.parameters.length; i++) {
            writeThreeAddressCode(node.parameters[i]);
        }

    } else if (node.type === 'assign') {

        writeThreeAddressCode(node.from);
        console.log('pop ' + node.to);

    } else if (node.type === 'function') {

        for (let i = 0; i < node.parameters.length; i++) {
            writeThreeAddressCode(node.parameters[i]);
        }
    }
}
var ast = parser.parse(str);
// console.log(JSON.stringify(ast, null, 4));
writeThreeAddressCode(ast);