'use strict';

var personnes = [
    { nom: 'Ion', prenom: 'Mihai', age: 35},
    { nom: 'Popescu', prenom: 'Stefan', age: 47},
    { nom: 'Dumitru', prenom: 'Ana-Maria', age: 19},
    { nom: 'Vasile', prenom: 'Anca', age: 22},
    { nom: 'Stanescu', prenom: 'George', age: 23}
];
var nom = process.argv[2];
var addresse = {
    ville: process.argv[3],
    rue: process.argv[4],
    numero: process.argv[5]
};

for(let p of personnes) {
    if(p.nom === nom) {
        p.addresse = addresse;
        console.log(p);
        break;
    }
}