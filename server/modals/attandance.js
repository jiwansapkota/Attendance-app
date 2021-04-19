var mangoose = require('mongoose')
var Schema = mangoose.Schema


var attandanceSchema = new Schema({
    attendence: {
        takenBy: {
            type: Object,
            require: true
        },
        Date: {
            type: Date,
            require: true
        },
        students: {
            type: Object,
            require: true
        }
    }

})
attandanceSchema.pre('save',function(next){
    next()
})

module.exports = mangoose.model('Attendence', attandanceSchema)