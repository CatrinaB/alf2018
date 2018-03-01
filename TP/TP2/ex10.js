'use strict';

var personne = {
    nom: 'Andrei',
    age: 20
};

var v = [];

for(let i = 0; i < Object.keys(personne).length; i++) {
    var paire = [];
    paire.push(Object.keys(personne)[i], Object.values(personne)[i]);
    v.push(paire);
}

console.log(v);