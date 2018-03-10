'use strict';

var fs = require('fs');

try {
    var data = fs.readFileSync(process.argv[2]).toString();
    var lines = data.split('\r\n');

    var classes = [];
    var className = '';
    for(let line of lines) {
        let classDeclaration = line.match(/class ([^\s]+)/);
        let functionDeclaration = line.match(/public (?=[^\s\{]+)(?!class)([^\{\(\s]+) ([^\{\(\s]+)\((([^\(\)]+)?)\)/);
        if(classDeclaration) {
            className = classDeclaration[1];
            let classInfo = {};
            classInfo.name = className;

            let interf = line.match(/implements ([^\s\{]+)/);
            if(interf) {
                classInfo.implements = interf[1];
            }

            let extended = line.match(/extends ([^\s\{]+)/);
            if(extended) {
                classInfo.extends = extended[1];
            }

            classInfo.functions = [];
            classes.push(classInfo);
        }
        else if(functionDeclaration) {
            let parameters = functionDeclaration[3].split(',');
            let parametersNr;
            if(parameters[0] === '') {
                parametersNr = 0;
            }
            else {
                parametersNr = parameters.length;
            }

            let funct = {
                name: functionDeclaration[2],
                return_type: functionDeclaration[1],
                parameters: parametersNr
            };

            for(let c of classes) {
                if(c.name === className) {
                    c.functions.push(funct);
                }
            }
        }
    }
    
    fs.writeFileSync('classes.json', JSON.stringify(classes, null, 2), 'utf8');

} catch(err) {
    console.error(err);
}