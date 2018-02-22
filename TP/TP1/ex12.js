'use strict';

var cowsay = require('cowsay');
var os = require('os');

var cpu = os.arch();
var system = os.type();
var totalMem_kB = os.totalmem()/1024;
var totalMem_MB = os.totalmem()/Math.pow(1024, 2);

var result = cpu + ' ' + system + ' ' + totalMem_kB + ' ' + totalMem_MB;
console.log(cowsay.say({text: result}));