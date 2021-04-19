var mangoose = require('mongoose')
var Schema = mangoose.Schema


var studentSchema = new Schema({
        student:{
            name:{ type:String, require:true},
            age:{type:Number, require: true},
            grade:{type:Number,require:true},
        }
})
// studentSchema.pre('save',function(next){
//     next()
// })

module.exports= mangoose.model('Student',studentSchema)