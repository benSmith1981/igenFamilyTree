
const FamilySchema = require('./detail_model'),
DiseaseSchema = require('./disease_model'),
LoginSchema = require('./login_model'),
date = new Date()

CollectionDriver = function(db) {
  this.db = db;
};

exports.deletetree = function(req, res, err) {

    var familyKey =  req.query.patientID
    console.log("familyKey " + familyKey)
    FamilySchema.remove({ patientID: familyKey}, function(err, callback){
        if (err) {
            res.json(err)
        }
        else {
            res.json(callback)
        }
    })

}

//req.body
//req.query
//req.params
// Create endpoint  to get tree json 
exports.savetree = function(req, res, err) {
    // res.json(req.body)
    // res.json(req.query)
    // res.json(req.params)
    var familyKey =  Object.keys(req.body)[0]
    console.log("familyKey " + familyKey)
    var allHumans = req.body[familyKey]
    var savedHumans = []

    FamilySchema.find({patientID: familyKey}, function(err, doc){ //function (err, callback) {
        if (!doc.length){
            Object.keys(allHumans).forEach(key => {
                let currentHuman = allHumans[key];
                console.log("key " + key)
                console.log("Name " + currentHuman.name)

                var familyTree = new FamilySchema( currentHuman )

                //dont' save if we find an id already stored
                
                familyTree.save(function (err, details) {
                    if (err) {
                        return res.json({ success:false, err })
                    }
                    else  {
                        console.log("Details saved "+ details)
                        // savedHumans.push({ "Saved" : details })
                    }
                })
            })
        }
    })

    res.json({success:true})
}

exports.addOneHuman = function(req, res, err) {
    var familyTree = new FamilySchema({  
        name: req.body.name,
        id: req.body.id,
        patientID: req.body.patientID
    })

    familyTree.save(function (err, details) {
        if (err) {
            res.json({ err })
            return console.error(err);
        }
        else  {
            res.json({ details })
        }
    })
}

exports.deletediseases = function(req, res, err) {
    console.log("delete diseases req.query.id "+ req.query.id)

    DiseaseSchema.remove({ id: req.query.id}, function(err, callback){
        if (err) {
                console.log("err "+ err)

            res.json(err)
        }
        else {
                            console.log("callback "+ callback)

            res.json(callback)
        }
    })

}

exports.adddiseases = function(req, res, err) {
    console.log("req.query.id "+ req.query.id)



    DiseaseSchema.findOne({id: req.query.id}, function (err, human) {
        if (human == null){
            console.log("human "+ human)

            var diseases = new DiseaseSchema(req.body)

            diseases.save(function (err, details) {
                if (err) {
                    res.json({ err })
                    return console.error(err);
                }
                else  {
                    res.json({ details })
                }
            })
        } 
        else{
            DiseaseSchema.update({id: req.query.id }, 
                {$set: req.body }, 
                {upsert: true}, 
            function(err, callback){
                console.log("callback "+ callback)

                if (err) return res.send(500, { error: err });
                return res.json(callback);

            })

        }
    })

}

// Create endpoint  to get tree json 
exports.getdiseases = function(req, res, err) {
    console.log("req.query.id "+ req.query.id)

    //callback is an array
    DiseaseSchema.find({id: req.query.id}, function (err, callback) {
        if (err) {
            res.json({ err })
            return console.error(err);
        } else {
            res.json(callback)
        }
    })

}

// Create endpoint  to get tree json 
exports.register = function(req, res, err) {
    console.log("req.query.username"+ req.body.username)
    console.log("req.query.password "+ req.body.password)
    console.log("req.query.id"+ req.body.id)
    console.log("req.query.patientID "+ req.body.familyTreeID)

    var login = new LoginSchema({  
        username: req.body.username,
        password: req.body.password,
        familyTreeID: req.body.familyTreeID,
        id: req.body.id
    })
    //callback is an array
    LoginSchema.find({username: req.body.username}, function(err, doc){ //function (err, callback) {
        if (!doc.length){
            login.save(function (err, details) {
                if (err) {
                    res.json({ err })
                    return console.error(err);
                }
                else  {
                    res.json({ details })
                }
            })
        } else {
            res.json({success: false, message:"Username used"})
        }
    })


}

// Create endpoint  to get tree json 
exports.login = function(req, res, err) {
    console.log("req.body.username"+ req.body.username)
    console.log("req.body.password "+ req.body.password)

    //callback is an array
    LoginSchema.findOne({username: req.body.username, password: req.body.password}, 
        function (err, callback) {
            if (!callback) {
                return res.json({success: false, message: "Login Details Incorrect"})
            }
            if (err) {
                res.json({ err })
                return console.error(err);
            } else {
                var userID = callback.id
                console.log("callback.id "+ callback.id)
                //callback is an array
                console.log("callback.familyTreeID"+ callback.familyTreeID)

                FamilySchema.find({patientID: callback.familyTreeID}, function (err, callback) {
                    if (err) {
                        res.json({ err })
                        return console.error(err);
                    } else {
                        res.json({userID: userID, familyTree: callback})
                    }
                })
        }
    })

}


exports.edithuman = function(req, res, err) {
    FamilySchema.update({id: req.query.id }, 
        {$set: req.body }, 
        {upsert: true}, 
        function(err, callback){
            if (err) return res.send(500, { error: err });
            return res.json(callback);

    })
}

//Create endpoint  to get tree json 
exports.gettree = function(req, res, err) {
    console.log("req.query.patientID "+req.query.patientID)

    var buildingString = ""
    //callback is an array
    FamilySchema.find({patientID: req.query.patientID}, function (err, callback) {
        if (err) {
            res.json({ err })
            return console.error(err);
        } else {
            res.json(callback)
        }
    })

}