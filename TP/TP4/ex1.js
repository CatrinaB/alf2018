'use strict';

var films = [
    'The Shawshank Redemption,1994,9.2',
    'The Dark Knight,2008,9.0',
    'Pulp Fiction,1994,8.9',
    'Fight Club,1999,8.8'
];

var regex = /([A-Za-z\s]+),([0-9]+),([0-9\.]+)/;

for(let film of films) {
    var info = regex.exec(film);
    console.log('Nom: ' + info[1] + ' Annee: ' + info[2] + ' Note: ' + info[3]);
}