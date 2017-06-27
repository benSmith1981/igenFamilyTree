/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Father {
//	public var height_feet : Int?
//	public var height_inches : Int?
//	public var weight_unit : String?
    
	public var name : String?
	public var gender : String?
	public var dateOfBirth : String?
	public var twinStatus : String?
    public var height_centimeters : String?
	public var weight : Int?
	public var healthHistory : Array<HealthHistory>?
	public var race : Race?
	public var ethnicity : Ethnicity?
    
    
//public var personID : UUID
//public var modificationTimeStamp : Date?
    
    
/*
    Returns an array of models based on given dictionary.
    Sample usage: let father_list = Father.modelsFromDictionaryArray(someDictionaryArrayFromJSON
        - parameter array:  NSArray from JSON dictionary.
        - returns: Array of Father Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Father]
    {
        var models:[Father] = []
        for item in array
        {
            models.append(Father(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let father = Father(someDictionaryFromJSON)
    - parameter dictionary:  NSDictionary from JSON.
    - returns: Father Instance.
*/
	required public init?(dictionary: NSDictionary) {

//		height_feet = dictionary["height_feet"] as? Int
//		height_inches = dictionary["height_inches"] as? Int
//		weight_unit = dictionary["weight_unit"] as? String
        
		name = dictionary["name"] as? String
		gender = dictionary["gender"] as? String
		dateOfBirth = dictionary["dateOfBirth"] as? String
		twinStatus = dictionary["twinStatus"] as? String
        height_centimeters = dictionary["height_centimeters"] as? String
		weight = dictionary["weight"] as? Int
		if (dictionary["Health History"] != nil) { healthHistory = HealthHistory.modelsFromDictionaryArray(array: dictionary["Health History"] as! NSArray) }
		if (dictionary["race"] != nil) { race = Race(dictionary: dictionary["race"] as! NSDictionary) }
		if (dictionary["ethnicity"] != nil) { ethnicity = Ethnicity(dictionary: dictionary["ethnicity"] as! NSDictionary) }
        
        
//      personID = dictionary["personID"] as! UUID
//      modificationTimeStamp = dictionary["modificationTimeStamp"] as? Date
        
	}

		
/**
    Returns the dictionary representation for the current instance.
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

//		dictionary.setValue(self.height_feet, forKey: "height_feet")
//		dictionary.setValue(self.height_inches, forKey: "height_inches")
//		dictionary.setValue(self.weight_unit, forKey: "weight_unit")
        
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.gender, forKey: "gender")
		dictionary.setValue(self.dateOfBirth, forKey: "dateOfBirth")
		dictionary.setValue(self.twinStatus, forKey: "twinStatus")
		dictionary.setValue(self.height_centimeters, forKey: "height_centimeters")
		dictionary.setValue(self.weight, forKey: "weight")
		dictionary.setValue(self.race?.dictionaryRepresentation(), forKey: "race")
		dictionary.setValue(self.ethnicity?.dictionaryRepresentation(), forKey: "ethnicity")
        
        
//      dictionary.setValue(self.personID, forKey: "personID")
//      dictionary.setValue(self.modificationTimeStamp, forKey: "modificationTimeStamp")
        
		return dictionary
	}

}
