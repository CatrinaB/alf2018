'use strict';

var fs = require('fs');

try {
    var data = fs.readFileSync('applet.java').toString();
    var lines = data.split('\r\n');

    var packages = [];
    var classes = [];
    var classesInfo = [];
    var functions = [];
    for(let line of lines) {
        let packageImport = line.match(/import ([^;]+);/);
        let classDeclaration = line.match(/class ([^\s]+)/);
        let functionDeclaration = line.match(/public ((?=[^\s\{]+)(?!class)[^\{\(]+)/);
        if(packageImport) {
            packages.push(packageImport[1]);
        }
        else if(classDeclaration) {
            classes.push(classDeclaration[1]);

            let classInfo = {};
            classInfo.name = classDeclaration[1];

            let interf = line.match(/implements ([^\s\{]+)/);
            if(interf) {
                classInfo.implements = interf[1];
            }

            let extended = line.match(/extends ([^\s\{]+)/);
            if(extended) {
                classInfo.extends = extended[1];
            }
            classesInfo.push(classInfo);
        }
        else if(functionDeclaration) {
            functions.push(functionDeclaration[1]);
        }
    }
    console.log(packages); //a
    console.log(classes); //b
    console.log(classesInfo); //c
    console.log(functions); //d

} catch(err) {
    console.error(err);
}