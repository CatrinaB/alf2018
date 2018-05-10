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

function pushThreeAddressCode (result, arg1, arg2, op)
{
    list.push ({
        result: result,
        arg1: arg1,
        arg2: arg2,
        op: op
    });
    // return the position where the three address code was pushed
    return list.length-1;
}
 
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
        node.result = {
                type: 'temp',
                value: nextVariable()
            };
        // list.push (node.result+' = '+node.left.result+' '+node.op+' '+node.right.result);
        var index = pushThreeAddressCode(node.result, node.left.result, node.right.result, node.op);
        node.result.item = index;
    }
    else
    if (node.type === 'number')
    {
        node.result = {
                type: 'number',
                value: node.value
            };
    }
    else
    if (node.type === 'id')
    {
        node.result = {
                type: 'id',
                value: node.value
            };
    }
    else
    if (node.type === 'assign')
    {
        writeThreeAddressCode(node.from);
        // list.push ('call '+node.id+', '+node.parameters.length);
        pushThreeAddressCode(null, node.to, node.from.result, '=');
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
            // list.push ('param '+parameter.result);
            pushThreeAddressCode(null, parameter.result, null, 'param');
        }
        // list.push ('call '+node.id+', '+node.parameters.length);
        node.result = {
            type: 'temp',
            value: nextVariable()
        };
        node.result.item = pushThreeAddressCode(node.result, node.id, node.parameters.length, 'call');
    }
}

var ast = parser.parse (str);
console.log (JSON.stringify(ast, null, 4));

writeThreeAddressCode(ast);

console.log (JSON.stringify(list, null, 4));
	