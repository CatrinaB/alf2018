'use strict';

var s = 'alf';
var subs = [];

for(let i = 0; i < s.length; i++) {
    for(let j = i + 1; j <= s.length; j++) {
        subs.push(s.substring(i, j));
    }
}

console.log(subs);