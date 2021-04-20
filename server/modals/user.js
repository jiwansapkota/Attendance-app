var mangoose = require('mongoose')
var Schema = mangoose.Schema
var bcrypt = require('bcrypt')
var userSchema = new Schema({
    email: {
        type: String,
        require: true
    },
    password: {
        type: String,
        require: true
    }

})

userSchema.pre('save', function (next) {
    var user = this;
    if (this.isModified('password') || this.isNew) {
        bcrypt.genSalt(10, function (err, salt) {
            if (err) {
                return next(err)
            }
            bcrypt.hash(user.password, salt, function (err, hash) {
                if (err) {
                    return next(err)
                }
                user.password = hash
                console.log("email is :" ,user.email);
                console.log("password is",user.password);
                next()

            })
        })
    }
    else {
        return next()
    }
})

userSchema.methods.comparePassword= function (password, cb){
    bcrypt.compare(password,this.password,function(err,isMatch){
        if(err){
            return cb(err);
        }
        return cb(null,isMatch);    
    })
}

module.exports = mangoose.model('User', userSchema)