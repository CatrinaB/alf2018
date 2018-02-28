'use strict';

var os = require('os');

console.log(os.arch());
console.log(os.type());
console.log(os.totalmem()/Math.pow(1024, 2));