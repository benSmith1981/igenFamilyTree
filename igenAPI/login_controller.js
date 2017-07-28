const LoginSchema = require('./login_model')
'use strict';
const nodemailer = require('nodemailer');

exports.verifymember = function(req, res, err) {
    var email = req.body.email //becomes user name
    var familyTreeID = req.body.patientID
    var userID = req.body.userID
    var passwordCode = generateCode()
    var name = req.body.name
    var patientname = req.body.patientname

    // create reusable transporter object using the default SMTP transport
    let transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 465,
        secure: true, // secure:true for port 465, secure:false for port 587
        auth: {
            user: 'igentester334@gmail.com',
            pass: 'igentester'
        }
    });
    // var doctorTextDutch = "<p>Beste, Door arts [arts naam] bent u uitgenodigd om de Next Generation Family app te downloaden. Door middel van deze app brengt u uw familiehistorie inclusief eventuele medische aandoeningen eenvoudig in kaart. Hierdoor wordt er tijdens het consult veel tijd bespaard waardoor de arts meer tijd heeft om u persoonlijk te woord te staan. We vragen u dan ook de Next Generation Family app zo compleet mogelijk in te vullen. Omdat uw privacy enorm belangrijk is voor ons, kunt u zelf aangegeven of u uw ingevulde medische gegevens wilt delen met uw familieleden. Deze optie is standaard uitgeschakeld en deze kunt u in het opties menu inschakelen. Stap 1: Download de Next Generation Family app Stap 2: Open deze e-mail opnieuw Stap 3: Uw persoonlijke Next Generation Family app code [code]. Hiermee wordt u automatisch aan [arts naam] gekoppeld.</p>", // plain text body
    var emailTextEnglish = "<p>Dear "+name+",</p> <p>Your family member has created an iGen family tree and asked you to verify your information that they have added about your health history. You don't have to share this information with anyone, other than the family doctor, but it will help to diagnose and treat your family better.</p><p>1) Download the iGen app 2) Login with this email "+email+", and this code: "+passwordCode+" 3) Find your information in the tree and confirm it</p><p>We hope you love the app and it helps you improve you and your families health</p><p>Yours "+patientname+"</p>"
    var emailTextDutch = "<p>Geachte "+name+", Uw familielid is een iGen-stamboom aangemaakt en heeft u gevraagd uw gegevens te verifi&euml;ren die zij over uw gezondheidshistorie hebben toegevoegd. U hoeft deze informatie niet te delen met iemand anders dan de huisarts, maar het zal u helpen bij het diagnosticeren en behandelen van uw familie beter.</p><p>1) Download de iGen app 2) Log in met deze email "+email+", en deze code: "+passwordCode+" 3) Zoek uw gegevens in de boom en bevestig het</p><p>We hopen dat u van de app houdt en het helpt u om uw gezondheid en uw gezin te verbeteren</p><p>De jouwe "+patientname+"</p>"
    var igenEmails = "susannebaars88@outlook.com, 9611838416m@gmail.com, userid@familieVanNuland.nl"
    var groupTestEmails = "<pmgeurts@gmail.com>, <userid@familieVanNuland.nl>, <achidfarooq@gmail.com>"

    // setup email data with unicode symbols
    let mailOptions = {
        from: "👻 <"+email+">", // sender address
        to: "<"+groupTestEmails+">", // list of receivers
        subject: 'Family requesting your help!', // Subject line
        text: '%s', emailTextDutch,
        html: '<b>'+emailTextDutch+'</b>'  // html body
    };
    // send mail with defined transport object
    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return res.send({response: false , message: error});
        }
        res.send({response: true, message:"Message "+ info.messageId +" sent: %s" + info.response});
    });

    //create new user with these details, so they can login
    var login = new LoginSchema({  
        username: email,
        password: passwordCode,
        familyTreeID: familyTreeID,
        id: userID
    })
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

function generateCode(){
    var min = 10000;
    var max = 99999;
    return num = Math.floor(Math.random() * (max - min + 1)) + min;
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
