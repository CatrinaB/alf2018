'use strict';

var a = [1, 2, 3];

console.log(a); //a

for(let i = 0; i < a.length; i++) {
    console.log(a[i]);
} //b

for(let i in a) {
    console.log(a[i]);
} //c

for(let i of a) {
    console.log(i);
}