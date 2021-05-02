var jwt = require('jwt-simple')
var config = require('../config/dbConfig')
var User = require('../modals/user')
var Student = require('../modals/student')
var Attendance=require('../modals/attendance')

var functions = {
    addNewUser: function (req, res) {
        console.log(" adduser api called");
        console.log('email is', req.body.email);
        // if ((!req.body.email) || (!req.body.password))
        if (!(req.body.email != null && req.body.password != null)) {
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            console.log("password and email not null");
            User.findOne({
                email: req.body.email
            },
                function (err, user) {
                    if (err) throw err
                    if (!user) {
                        var newUser = User({
                            email: req.body.email,
                            password: req.body.password
                        });
                        console.log(newUser.email);
                        newUser.save(function (err, newUser) {
                            if (err) {
                                res.json({ success: false, msg: 'failed to save' })
                            }
                            else {
                                res.json({ success: true, msg: 'Successfully Saved' })
                            }
                        })
                    }
                    else {
                        res.json({
                            success: false,
                            msg: "User already exist for this email"
                        })
                    }
                })

        }
    },
    authenticate: function (req, res) {
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
                        var newUser = user
                        delete newUser['password']
                        console.log(newUser)
                        var token = jwt.encode(newUser, config.secret)
                        res.json({
                            success: true,
                            token: token,
                            msg: "User authenticated"
                        })

                    }
                    else {
                        return res.status(403).send({
                            success: false,
                            msg: "Authentication Failed, Wrong Password"

                        })
                    }

                })
            }
        })


    },
    getUserInfo: function (req, res) {
        console.log(req.headers);
        if (req.headers.authorization && req.headers.authorization.split(" ")[0] == 'Bearer') {
            var token = req.headers.authorization.split(" ")[1]
            var decodedToken = jwt.decode(token, config.secret)
            return res.json({
                success: true,
                token: decodedToken,
                msg: "hello" + decodedToken.email,
            })
        }
        else {
            console.log(req.headers.authorization.split(" ")[0]);
            return res.json({
                success: false,
                msg: "no headers"
            })
        }

    }
    ,
    addNewStudent: function (req, res) {
        console.log("addstudent api called")
        console.log("name :" + req.body.name + "grade:" + req.body.grade)
        if (!(req.body.name !== null && req.body.age != null && req.body.grade != null)) {
            console.log("request body is null")
            res.json({ success: false, msg: 'Enter all fields' })
        }
        else {
            console.log("name and grade not null ")
            Student.findOne({
                name: req.body.name,
                age: req.body.age,
            }, function (err, student) {
                if (err) throw err
                if (!student) {
                    var newStudent = Student({
                        name: req.body.name,
                        age: req.body.age,
                        grade: req.body.grade
                    });
                    newStudent.save(function (err, newStudent) {
                        if (err) {
                            res.json({ success: false, msg: 'failed to save' })
                        }
                        else {
                            res.json({ success: true, msg: 'Successfully Saved' })
                        }
                    })
                }
                else {
                    res.json({
                        success: false,
                        message: "Student already exist for this name and age"
                    })
                }
            })
        }
            // function (err, student) {
            //     if (err) throw err
            //     if (!student) {
            //         var newStudent = Student({
            //             name: req.body.name,
            //             age: req.body.age,
            //             grade: req.body.grade
            //         })
            //         newStudent.save(function (err, student) {
            //             if (err) {
            //                 res.json({ success: false, msg: 'failed to save' })
            //             }
            //             else {
            //                 console.log(student);
            //                 res.json({ success: true, msg: 'Successfully Saved' })
            //             }
            //         })

            //     }
            //     else {
            //         res.json({
            //             success: false,
            //             msg: "Cannot Add, Student already exist"
            //         })
            //     }
            // })
    },
    getStudents: function (req, res) {
        if (!req.body) {
            res.json({ success: false, msg: 'Enter valid grade' })
        }
        else {
            Student.find({ grade: req.body.grade }, function (err, students) {
                if (err) throw err
                if (students) {
                    res.json({
                        success: true,
                        msg: 'Successfully retrieved students',
                        students: students
                    })
                }
                else {
                    res.json({
                        success: false,
                        msg: "no student found, Enter valid Grade"
                    })
                }
            })
        }

    },
    postAttendence: function(req,res){
        console.log(req.body);
        if(req.body!=null){
            Attendance(req.body).save(function (err, newUser) {
                if (err) {
                    res.json({ success: false, msg: 'failed to save' })
                }
                else {
                    res.json({ success: true, msg: 'Successfully Saved' })
                }
            })
        }
       else{
        res.json({
            success:false,
            body:req.body,
            msg:"empty request body"
        })
       }
    }



}
module.exports = functions