var mangoose = require('mongoose')
var Schema = mangoose.Schema


var attandanceSchema = new Schema({
    attendence: {
        takenBy: [Schema.types.ObjectId],
        Date: {
            type: Date,
            require: true
        },
        students:[Schema.types.ObjectId],           
        
    }

})
// attandanceSchema.pre('save',function(next){
//     next()
// })

module.exports = mangoose.model('Attendence', attandanceSchema)