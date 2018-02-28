'use strict';

var os = require('os');
var uptime = os.uptime();

console.log('The system is running for: ' + uptime);

uptime = Math.floor(uptime);

if(uptime % 2 === 0) {
    console.log('The system has been running for an even number of seconds');
}
else {
    console.log('The system has been running for an odd number of seconds');
}