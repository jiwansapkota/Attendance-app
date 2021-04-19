var mangoose = require('mongoose')
var Schema = mangoose.Schema


var studentSchema = new Schema({
        Student:{
            name:{ type:String, require:true},
            age:{type:Int8Array, require: true},
            grade:{type:String,require:true},
        }
})
studentSchema.pre('save',function(next){
    next()
})

module.exports= mangoose.model('Student',studentSchema)