'use strict';

for(let i = 1; i <= 10000; i++) {
    console.log(i);
} //a

for(let i = 10000; i >= 1; i--) {
    console.log(i);
} //b

for(let i = 1; i <= 10000; i++) {
    if(i % 7 === 0) {
        console.log(i);
    }
} //c

for(let i = 1; i <= 10000; i++) {
    if(i % 3 === 0 && i % 5 === 0) {
        console.log(i);
    }
} //d

for(let i = 1; i <= 10000; i++) {
    if(i % 5 === 0 || i % 7 === 0) {
        console.log(i);
    }
} //e