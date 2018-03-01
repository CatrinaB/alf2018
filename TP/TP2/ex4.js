'use strict';

function circleArea(r) {
    return Math.PI * Math.pow(parseInt(r), 2);
}

function circleCircumference(r) {
    return 2 * Math.PI * parseInt(r);
}


var r = process.argv[2];

console.log(circleArea(r));
console.log(circleCircumference(r));
