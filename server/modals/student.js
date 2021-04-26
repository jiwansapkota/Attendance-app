var mangoose = require('mongoose')
var Schema = mangoose.Schema


var studentSchema = new Schema({
    name: {
        type: String,
        require: true
    },
    roll:{
        type: Number,
        require: true,
    },
    age: {
        type: Number,
        min: 0, max: 120,
        require: true
    },
    grade: {
        type: Number,
        require: true
    },
})
// studentSchema.pre('save',function(next){
//     next()
// })

module.exports = mangoose.model('Student', studentSchema)