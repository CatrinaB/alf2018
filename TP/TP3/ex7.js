'use strict';

var fs = require('fs');

try {
    var passwd = fs.readFileSync('passwd.txt').toString();
    var users = passwd.split('\r\n');

    var regex = /([a-zA-Z,_-]+):([a-zA-Z]):([0-9]+):([0-9]+):([a-zA-Z\s,\-()]+)?:([a-z\/]+):([a-z\/]+)/;
    
    for(let u of users) {

        var userData = regex.exec(u).splice(1, regex.exec(u).length - 1);
        var user = {
            username: userData[0],
            password: userData[1],
            userID: userData[2],
            userIDInfo: userData[4],
            groupID: userData[3],
            homeDir: userData[5],
            command: userData[6]
        };

        if(user.userIDInfo === undefined) {
            delete user.userIDInfo;
        }

        console.log(user);
    }

} catch(err) {
    console.error(err);
}