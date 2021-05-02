const express = require('express')
const router = express.Router()
const actions = require('../methods/actions')
var jwt = require('jwt-simple')

router.get('/',(req,res)=>{
    res.send("hello world");
})
router.post('/dashboard',(req,res)=>{
    res.send("hello world from dashboard");
})

//@desc adding new users
//@route POST /adduser
 router.post('/adduser',actions.addNewUser)
 //@desc authenticating user 
 router.post('/authenticate',actions.authenticate)
 //desc getting user
 router.get('/getuserinfo',actions.getUserInfo)
 //desc adding students
 router.post('/addstudent',actions.addNewStudent)
 router.post('/getstudents',actions.getStudents)
 router.post('/postattendence',actions.postAttendence)



module.exports = router  