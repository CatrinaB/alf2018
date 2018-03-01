'use strict';

var personne = {
    nom: process.argv[2],
    prenom: process.argv[3],
    age: process.argv[4]
};

console.log(personne); //a

console.log(Object.keys(personne)); //b

var personnes = [
    { nom: 'Ion', prenom: 'Mihai', age: 35},
    { nom: 'Popescu', prenom: 'Stefan', age: 47},
    { nom: 'Dumitru', prenom: 'Ana-Maria', age: 19},
    { nom: 'Vasile', prenom: 'Anca', age: 22},
    { nom: 'Stanescu', prenom: 'George', age: 23}
]; //c

var min = personnes[0];
for(let p of personnes) {
    if(min.age > p.age) {
        min = p;
    }
}
console.log(min); //d

var sum = 0;
for(let p of personnes) {
    sum += p.age;
}
console.log(sum/personnes.length); //e

var pers = personnes[0];
for(let p of personnes) {
    if(p.nom.length > pers.nom.length) {
        pers = p;
    }
}
console.log(pers); //f

console.log(personnes.sort(function(p1, p2) {
    if(p1.nom < p2.nom) {
        return -1;
    }

    if(p1.nom > p2.nom) {
        return 1;
    }

    return 0;
})); //g