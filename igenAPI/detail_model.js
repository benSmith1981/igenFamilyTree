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
    ethnicity : String, //"Caucasion",
    showDiseaseInfoToFamily : Boolean,
    smoker : Boolean,
    workout : Boolean,
    partners: [String],
    parents: [ String ], //[ { "id" : "id2" }, { "id" : "id3"} ],
    siblings: [ String ],
    children: [String ]

})

var DiseaseSchema = new mongoose.Schema({

    humanID: String, //"1",
    diseaseList: [String, String], //[ { "id" : 7 }, { "id" : 15 } ],
    canEditList: [String, String], //[ { "id" : "2" }, { "id" : "3"}, { "id" : "4"} ],
    editInfoID: Number,  //"1"
    editInfoTimestamp: Number, //12.345,
    editInfoField: String, //"nr. 7",
    deleted: Boolean

})
// Export the Mongoose model
module.exports = mongoose.model('FamilyDetails', FamilySchema);