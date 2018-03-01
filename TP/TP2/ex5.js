'use strict';

var a = [];
var sum = 0;

for(let i = 0; i < 10; i++) {
    a.push(Math.floor(Math.random() * 100));
    sum += a[i];
}

console.log(sum);