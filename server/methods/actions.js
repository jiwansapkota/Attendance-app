var User = require('../modals/user')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig')

var functions = {
    addNew: function (req, res) {
        console.log(" adduser api called");
        console.log(req.body.email);
        console.log('email is', req.body.email);
        // if ((!req.body.email) || (!req.body.password))
        if(!(req.body.email!=null&& req.body.password!=null))
         {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            console.log("name and email not null");
            var newUser = User({
                name: req.body.email,
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