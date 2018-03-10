'use strict';

var fs = require('fs');

try {
    var data = fs.readFileSync('java_errors.txt').toString();
    var errors = data.split(/[\.\^]\r\n/);

    var errorsNr = 0;
    var notesNr = 0;
    var table = [];

    for(let e of errors) {
        if(e.indexOf('error') >= 0) {
            errorsNr++;

            let error = {
                type: 'error',
                line: e.split(':')[1],
                filename: e.split(':')[0],
                description: e.split('error:')[1].trim()
            };

            table.push(error);
        }
        else if(e.indexOf('Note') >= 0) {
            notesNr++;

            let note = {
                type: 'note',
                description: e.split(': ')[1]
            };

            table.push(note);
        }
    }

    console.log(errorsNr); //a
    console.log(notesNr); //b
    console.log(table); //c

    fs.writeFileSync('errors.json', JSON.stringify(table, null, 2), 'utf8');

} catch(err) {
    console.error(err);
}