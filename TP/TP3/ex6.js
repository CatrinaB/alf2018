'use strict';

var fs = require('fs');

try {
    var table = fs.readFileSync('1220.csv').toString();

    var students = table.split('\r\n');

    for(let s of students) {
        var match = s.match(/[0-9]+;([A-Za-zÀ-ž-]+) ([A-Za-zÀ-ž.]+ )?([A-Za-zÀ-ž -]+);([0-9]+[A-Z])/);
        let student = {
            lastName: match[1],
            initials: match[2],
            firstName: match[3],
            group: match[4]
        };

        if(student.initials === undefined) {
            delete student.initials;
        }

        console.log(student);
    }

} catch(err) {
    console.error(err);
}