
// Get the packages we need
const express = require('express'),
    mongoose = require('mongoose'),
    bodyParser = require('body-parser'),
    path = require('path'),
    fs = require('fs'),
    request = require('request');

var detailRoutes = require('./detail_routes')

// Create our Express application
var app = express();
var port = process.env.PORT || 3000;
var router = express.Router();

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json());


// mongoose.connect(process.env.MONGODB_URI||  'mongodb://localhost/api/', function (error) {
//     if (error) console.error(error);
//     else console.log('mongo connected');
// });
// connect local or with heroku
//{ user: "heroku_d1t7ds7m", account: "heroku_d1t7ds7m" }
//mongodb://<dbuser>:<dbpassword>@ds051868.mlab.com:51868/heroku_d1t7ds7m
var uri = 'mongodb://heroku_d1t7ds7m:2u2rc279bb098tf4nk1eunkjbm@ds051868.mlab.com:51868/heroku_d1t7ds7m'
mongoose.connect(uri , function (error) {
    if (error) console.error(error);
    else console.log('mongo connected');
});


// parameters sent with 
router.post('/', function(req, res) {
  //Guesss you can check for parameters here
});

router.get('/', function(req, res) {
  //Guesss you can check for parameters here
})

// ROUTES
detailRoutes(router)

// Register all our routes with /api
app.use('/api', router);

// app.post( '/api', router);
// route connection
// Tell our app to listen on port 3000
app.listen(port, function (err) {
  if (err) {
    throw err
  }
 
  console.log('Server started on port 3000')
})