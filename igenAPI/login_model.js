'use strict'
// Load required packages
var mongoose = require('mongoose');

var LoginSchema = new mongoose.Schema({
	username: String,
	password: String,
	patientID: String,
	id: String
})

module.exports = mongoose.model('Login', LoginSchema);