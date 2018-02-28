'use strict';

var number = 72;
var divisors = 1;
var i = 2;

while(i <= number) {
    if(number % i === 0) {
        divisors++;
    }
    i++;
}

console.log('The number ' + number + ' has ' + divisors + ' divisors');

if(divisors <= 2) {
    console.log('The number is prime');
}
else {
    console.log('The number is not prime')
}