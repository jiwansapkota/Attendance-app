var User = require('../modals/user')
var jwt = require('jwt-simple')
var config = require('../config/dbConfig');
const user = require('../modals/user');
const dbConfig = require('../config/dbConfig');

var functions = {
    addNew: function (req, res) {
        console.log(" adduser api called");
        console.log('email is', req.body.email);
        // if ((!req.body.email) || (!req.body.password))
        if (!(req.body.email != null && req.body.password != null)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            console.log("name and email not null");
            console.log(req.body.email);
            var newUser = User({
                email: req.body.email,
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
    },
    authnticate: function (req, res) {
        console.log(" fetchNew api called");
        console.log('email is', req.body.email);
        User.findOne({
            email: req.body.email
        }, function (err, user) {
            if (err) throw err
            if (!user) {
                res.status(403).send({ success: false, msg: "Authentication failed, User not found" })
            }
            else {
                user.comparePassword(req.body.password, function (err, isMatch) {
                    if (isMatch && !(err)) {
                        var token = jwt.encode(user,dbConfig.secret)
                        res.json({
                            success: true,
                            msg: "User authenticated"
                        })

                    }
                    else{
                        return res.status(403).send({
                            success:false,
                            msg:"Authentication Failed, Wrong Password"

                        })
                    }

                })
            }
        })


    }
}
module.exports = functions