var User = require('../modals/user')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')

var functions = {
    addNew: function (req, res) {
        console.log("sth sth")
        console.log('name is', req.body.name);
        if ((!req.body.name) || (!req.body.password)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            var newUser = User({
                name: req.body.name,
                password: req.body.password
            });
            newUser.save(function (err, newUser) {
                if (err) {
                    res.json({ success: false, msg: 'failed to save' })
                }
                else {
                    res.json({ success: true, msg: 'Successfully Saved' })
                }
            })

        }
    }
}
module.exports = functions