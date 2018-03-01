'use strict';

function sum1(a, b) {
    console.log(a + b);
} //a

function sum2(a, b) {
    return a + b;
} //b

sum1(3, 4);
console.log(sum2(3, 4));

var sum = sum2(3, 4);
console.log(sum); //c