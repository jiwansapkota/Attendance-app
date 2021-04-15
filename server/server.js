const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const connectDB = require('./config/db');
const passport= require('passport');
const bodyParser = require('body-parser');
const routes = require('./routes/index');

const MongoClient = require('mongodb').MongoClient;
const uri = "mongodb+srv://jiwansapkota:jiwansapkota@cluster0.p7fyi.mongodb.net/sample_analytics?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
client.connect(err => {
  const collection = client.db("test").collection("devices");
  // perform actions on the collection object
  client.close();
});

connectDB();

const app =express()
if(process.env.NODE_ENV==='development'){
    app.use(morgan('dev'))
}

app.use(routes)
app.use(express.json())
app.use(express.urlencoded({extended:true}))
app.use(cors)

const PORT= process.env.PORT || 3000
app.listen(PORT,console.log(` server running in ${process.env.NODE_ENV} mode on port ${PORT}`));