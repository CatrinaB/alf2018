'use strict';

var os = require('os');
var fs = require('fs');

var cpu = os.arch();
var system = os.type();
var totalMem_kB = os.totalmem()/1024;
var totalMem_MB = os.totalmem()/Math.pow(1024, 2);

var result = cpu + ' ' + system + ' ' + totalMem_kB + ' ' + totalMem_MB;
console.log(result);

try {
    fs.writeFileSync('system.info', result, 'utf8');
} catch(err) {
    console.log('Erreur!');
}