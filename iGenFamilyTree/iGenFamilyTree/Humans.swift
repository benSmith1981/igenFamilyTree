/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Humans {
    public var FamilyID : Array<Humans>?
	public var name : String?
	public var dob : Int?
	public var id : Int?
	public var race : String?
	public var gender : String?
	public var partners : Array<Humans>?
	public var parents : Array<Humans>?
	public var siblings : Array<Humans>?
    public var children : Array<Humans>?
    

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let humans_list = Humans.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Humans Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Humans]
    {
        var models:[Humans] = []
        for item in array
        {
            models.append(Humans(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let humans = Humans(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Humans Instance.
*/
	required public init?(dictionary: NSDictionary) {

		name = dictionary["name"] as? String
		dob = dictionary["dob"] as? Int
		id = dictionary["id"] as? Int
		race = dictionary["race"] as? String
		gender = dictionary["gender"] as? String
		if (dictionary["partners"] != nil) { partners = Humans.modelsFromDictionaryArray(array: dictionary["partners"] as! NSArray) }
		if (dictionary["parents"] != nil) { parents = Humans.modelsFromDictionaryArray(array: dictionary["parents"] as! NSArray) }
		if (dictionary["siblings"] != nil) { siblings = Humans.modelsFromDictionaryArray(array: dictionary["siblings"] as! NSArray) }
        if (dictionary["children"] != nil) { siblings = Humans.modelsFromDictionaryArray(array: dictionary["children"] as! NSArray) }
        
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.dob, forKey: "dob")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.race, forKey: "race")
		dictionary.setValue(self.gender, forKey: "gender")
        dictionary.setValue(self.children, forKey: "children")
        dictionary.setValue(self.FamilyID, forKey: "familyID1")

		return dictionary
	}

}
