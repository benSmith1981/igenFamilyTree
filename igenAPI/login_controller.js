const LoginSchema = require('./login_model')


exports.verifymember = function(req, res, err) {
    var email = req.body.email //becomes user name
    var familyTreeID = req.body.patientID
    var userID = req.body.userID
    var password = req.body.code
    //send verify email
    //"Login with your email and this code"

    //create new user with these details, so they can login
}
exports.addpatientsid = function(req, res, err) {
    LoginSchema.update({id: req.body.username }, 
        {$set: {familyTreeID:req.body.patientID, id: req.body.patientID} }, 
        {upsert: true}, 
        function(err, callback){
            if (err) return res.send(500, { error: err });
            return res.json(callback);

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
