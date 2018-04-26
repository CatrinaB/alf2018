"use strict";
 
// import fs for reading 
var fs = require ('fs');
 
// import the generated Parser
var parser = require ('./../program.js').parser;
 
var str = fs.readFileSync (process.argv[2], 'UTF-8');
 
var variable_id = 0;
 
 
function nextVariable ()
{
    return 'variable'+variable_id++;
}

var list = [];

function writeThreeAddressCode (node)
{
    if (node.type === 'script')
    {
        for (var statementIndex in node.statements)
        {
            writeThreeAddressCode(node.statements[statementIndex]);
        }
    }
    else
    if (node.type === 'expr')
    {
        writeThreeAddressCode(node.left);
        writeThreeAddressCode(node.right);
        node.result = nextVariable();
        list.push (node.result+' = '+node.left.result+' '+node.op+' '+node.right.result);
    }
    else
    if (node.type === 'number')
    {
        node.result = node.value;
    }
    else
    if (node.type === 'id')
    {
        node.result = node.value;
    }
    else
    if (node.type === 'assign')
    {
        writeThreeAddressCode(node.from);
        list.push (node.to+' = '+node.from.result);
    }
    else
    if (node.type === 'function_run')
    {
        var parameterIndex;
        var parameter;
        for (parameterIndex in node.parameters)
        {
            parameter = node.parameters[parameterIndex];
            writeThreeAddressCode(parameter);
        }
        for (parameterIndex in node.parameters)
        {
            parameter = node.parameters[parameterIndex];
            list.push ('param '+parameter.result);
        }
        node.result = nextVariable();
        list.push (node.result+' = call '+node.id+', '+node.parameters.length);
    }
}

var ast = parser.parse (str);
console.log (JSON.stringify(ast, null, 4));

writeThreeAddressCode(ast);

console.log (JSON.stringify(list, null, 4));
	