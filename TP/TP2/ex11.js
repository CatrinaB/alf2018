'use strict';

function compare(prop) {
    
    return function(p1, p2) {

        if(p1[prop] < p2[prop]) {
            return -1;
        }

        if (p1[prop] > p2[prop]) {
            return 1;
        }

        return 0;
    }
}

var personnes = [
    { nom: 'Ion', prenom: 'Mihai', age: 35},
    { nom: 'Popescu', prenom: 'Stefan', age: 47},
    { nom: 'Dumitru', prenom: 'Ana-Maria', age: 19},
    { nom: 'Vasile', prenom: 'Anca', age: 15},
    { nom: 'Stanescu', prenom: 'George', age: 52}
];

console.log(personnes.sort(compare('age')));
console.log(personnes.sort(compare('prenom')));