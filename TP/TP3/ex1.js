'use strict';

var s = '19;ŞUTEU L.M. Mihaela-Andreea;1221 F';

console.log(s.indexOf('Mihaela')); //a
console.log(s.lastIndexOf(';')); //b

var a = s.split(';');
var name = a[1].split(' ');

for(let i of name) {
    console.log(i);
} //c