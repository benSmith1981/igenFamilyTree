/*
 Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Person {
    //	public var height_feet : String?
    //	public var height_inches : String?
    //	public var weight_unit : String?
    
    public var name : String?
    public var gender : String?
    public var date_of_birth : String?
    public var twin_status : String?
    public var height_centimeters : String?
    public var weight : String?
    public var healthHistory : Array<HealthHistory>?
    public var race : Race?
    public var ethnicity : Ethnicity?
    public var parents : Array<Parents>?
    
    
    public var personID : UUID
    public var modificationTimeStamp : Date?
    
    
    /**
     Returns an array of models based on given dictionary.
     Sample usage: let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     - parameter array:  NSArray from JSON dictionary.
     - returns: Array of Json4Swift_Base Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Person]
    {
        var models:[Person] = []
        for item in array
        {
            models.append(Person(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     Sample usage: let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)
     - parameter dictionary:  NSDictionary from JSON.
     - returns: Json4Swift_Base Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        name = dictionary["name"] as? String
        gender = dictionary["gender"] as? String
        date_of_birth = dictionary["date_of_birth"] as? String
        twin_status = dictionary["twin_status"] as? String
        height_centimeters = dictionary["height_centimeters"] as? String
        weight = dictionary["weight"] as? String
        if (dictionary["Health History"] != nil) { healthHistory = HealthHistory.modelsFromDictionaryArray(array: dictionary["Health History"] as! NSArray) }
        if (dictionary["race"] != nil) { race = Race(dictionary: dictionary["race"] as! NSDictionary) }
        if (dictionary["ethnicity"] != nil) { ethnicity = Ethnicity(dictionary: dictionary["ethnicity"] as! NSDictionary) }
        if (dictionary["parents"] != nil) { parents = Parents.modelsFromDictionaryArray(array: dictionary["parents"] as! NSArray) }
        
        
        personID = dictionary["personID"] as! UUID
        modificationTimeStamp = dictionary["modificationTimeStamp"] as? Date
        
        
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.date_of_birth, forKey: "date_of_birth")
        dictionary.setValue(self.twin_status, forKey: "twin_status")
        dictionary.setValue(self.height_centimeters, forKey: "height_centimeters")
        dictionary.setValue(self.weight, forKey: "weight")
        dictionary.setValue(self.race?.dictionaryRepresentation(), forKey: "race")
        dictionary.setValue(self.ethnicity?.dictionaryRepresentation(), forKey: "ethnicity")
        
        
        dictionary.setValue(self.personID, forKey: "personID")
        dictionary.setValue(self.modificationTimeStamp, forKey: "modificationTimeStamp")
        
        
        return dictionary
    }
    
}
