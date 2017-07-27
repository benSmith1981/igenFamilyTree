const DiseaseSchema = require('./disease_model')

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