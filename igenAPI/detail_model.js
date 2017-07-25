'use strict'
// Load required packages
var mongoose = require('mongoose');

// Define our client schema
var FamilySchema = new mongoose.Schema({

    name: String,
    patientID: String, // "Family1", this is the id of the patient and for the family
    id: String , //"Family1", this is unique
    dob: String, //"1981",
    gender: String,  //"male"
    twin : Boolean,
    adopted : Boolean,
    heightCM : Number,//1.83,
    weightKG : Number,//80 ,
    race : String, //"Caucasion",
    showDiseaseInfo : Boolean,
    smoker : Boolean,
    workout : Boolean,
    spouses: [String],
    parents: [ String ], //[ { "id" : "id2" }, { "id" : "id3"} ],
    siblings: [ String ],
    children: [ String ],
    editInfoID: String,  //"1"
    editInfoTimestamp: String, //12.345,
    editInfoField: String //"nr. 7",

})

// Export the Mongoose model
module.exports = mongoose.model('FamilyDetails', FamilySchema);