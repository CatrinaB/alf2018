'use strict';

var fs = require('fs');

try {
    var table = fs.readFileSync('1220.csv').toString();

    var students = table.split('\r\n'); //a

    for(let i in students) {
        console.log(students[i].split(';')[2]);
        console.log(students[i].split(';')[1].split(' ').join('\r\n'));
        console.log();
    }

} catch(err) {
    console.error(err);
}