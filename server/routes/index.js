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
 //desc adding students
 router.post('/addstudents',actions.addNewStudent)
 router.get('/getstudents',actions.getStudents)

module.exports = router  