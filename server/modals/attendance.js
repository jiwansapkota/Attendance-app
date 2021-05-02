var mangoose = require('mongoose')
var Schema = mangoose.Schema


var attendanceSchema = new Schema({
    takenBy: {
        type: String,
        require: true
    },
    date: {
        type: String,
        require: true
    },
    students: [{
        name: {
            type: String,
            require: true
        },
        roll: {
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
        isPresent:{
            type:Boolean,
            require: true,
        }
    }],

})
module.exports = mangoose.model('Attendance', attendanceSchema)