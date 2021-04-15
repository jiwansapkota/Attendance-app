const mongoose = require('mongoose');
const dbConfig = require('./dbConfig')

const connectDB= async()=>{
    try{
        console.log('process entered to connect database');
        const conn= await mongoose.connect(dbConfig.database,{
            useNewUrlParser:true,
            useUnifiedTopology:true,
            useFindAndModify:false,

        });
        console.log("database connected");
    }
    catch(e){
        console.log("error occured")
        console.log(e)
        process.exit(1)

    }
}
module.exports = connectDB