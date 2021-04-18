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
 router.post('/adduser',actions.addNew)
 router.post('/authenticate',actions.authnticate)

 router.post('/new',(req,res)=>{
     console.log("api called");
     console.log("this is request body"+req.body);
     res.json({msg:"successfully connected"})
 }) 

module.exports = router  