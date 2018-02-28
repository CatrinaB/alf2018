'use strict';

var os = require('os');
var chalk = require('chalk');

var cpu = os.arch();
var system = os.type();
var totalMem_kB = os.totalmem()/1024;
var totalMem_MB = os.totalmem()/Math.pow(1024, 2);

console.log(chalk.blue(cpu));
console.log(chalk.red(system));
console.log(chalk.green(totalMem_kB));
console.log(chalk.magenta(totalMem_MB));