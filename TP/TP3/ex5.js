'use strict';

var s = '19;ŞUTEU L.M. Mihaela-Andreea;1221F';

var regex = /[0-9]+;([A-Za-zÀ-ž-]+) ([A-Za-zÀ-ž.]+ )?([A-Za-zÀ-ž -]+);([0-9]+[A-Z])/;

var match = regex.exec(s);
console.log(match.splice(1, 5).join('\n'));