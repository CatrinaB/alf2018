"use strict";

var assert = require ('assert');
var util = require ('util');
var _ = require ('lodash');

var originalFile = process.argv[2];
var verifyFile = process.argv[3];
var points = parseInt (process.argv[4]);
var verify = process.argv[5];

var originalTree;
var verifyTree;

// console.log (process.argv);

try
{
	originalTree = require ('./'+originalFile);
}
catch (e)
{
	console.error ('Cannot load original tree from '+originalFile);
	process.exit (-1);
}

try
{
	verifyTree = require ('./'+verifyFile);
}
catch (e)
{
	console.error ('Cannot load tree from '+verifyFile);
	process.exit (-1);
}

if (_.isEqualWith (originalTree, verifyTree))
{
	
}
else
{
	// console.log ('Variables are allocated differently');
	process.exit (-1);
}
