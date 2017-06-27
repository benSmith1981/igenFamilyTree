/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Race {
	public var americanIndianOrAlaskaNative : String?
	public var asian : String?
	public var blackOrAfricanAmerican : String?
	public var nativeHawaiianOrOtherPacificIslander : String?
	public var white : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let race_list = Race.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Race Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Race]
    {
        var models:[Race] = []
        for item in array
        {
            models.append(Race(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let race = Race(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Race Instance.
*/
	required public init?(dictionary: NSDictionary) {

		americanIndianOrAlaskaNative = dictionary["American Indian or Alaska Native"] as? String
		asian = dictionary["Asian"] as? String
		blackOrAfricanAmerican = dictionary["Black or African-American"] as? String
		nativeHawaiianOrOtherPacificIslander = dictionary["Native Hawaiian or Other Pacific Islander"] as? String
		white = dictionary["White"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.americanIndianOrAlaskaNative, forKey: "American Indian or Alaska Native")
		dictionary.setValue(self.asian, forKey: "Asian")
		dictionary.setValue(self.blackOrAfricanAmerican, forKey: "Black or African-American")
		dictionary.setValue(self.nativeHawaiianOrOtherPacificIslander, forKey: "Native Hawaiian or Other Pacific Islander")
		dictionary.setValue(self.white, forKey: "White")

		return dictionary
	}

}
