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

 router.post('/name',(req,res)=>{
     console.log("api called")
     console.log(req.body);
     if(!(req.body.name==null)){
     res.json({
         success: true,
         msg: "successfully created a post api"
     })}

 }) 

module.exports = router  