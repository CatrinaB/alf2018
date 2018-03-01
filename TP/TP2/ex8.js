'use strict';

function hasProperty(object, property) {
    
    let properties = Object.keys(object);
    
    if(properties.indexOf(property) >= 0) {
        return true;
    }

    return false;
}

var personne = {
    nom: 'Popescu',
    prenom: 'Andrei',
    age: 20
};

console.log(hasProperty(personne, 'age'));
console.log(hasProperty(personne, 'addresse'));