import Foundation

typealias ID = String

struct Human {
    var name: String
    var id: ID?
    var gender: String
    var dob : String?
    var race : String?
    var processed: Bool = false
    var spouses: [ID] = []
    var parents: [ID] = []
    var children: [ID] = []
    var siblings: [ID] = []
    
    init(name: String, gender: String) {
        self.name = name
        self.gender = gender
    }
    
    init?(id: ID, dictionary: NSDictionary) {
        
        self.init(name: (dictionary["name"] as? String)!,
                  gender: (dictionary["gender"] as? String)!)
        self.id = id
        self.dob = dictionary["dob"] as? String
        self.race = dictionary["race"] as? String
        let parentsParsed = dictionary["parents"] as! NSArray
        
        for parent in parentsParsed {
            if let parent = parent as? NSDictionary, let parentID = parent["id"] as? ID {
                self.parents.append(parentID)
            }
        }
        
        let siblingsParsed = dictionary["siblings"] as! NSArray
        for sibling in siblingsParsed {
            if let sibling = sibling as? NSDictionary, let siblingID = sibling["id"] as? ID {
                siblings.append(siblingID)
            }
        }
        
        let childrenParsed = dictionary["children"] as! NSArray
        for child in childrenParsed {
            if let child = child as? NSDictionary, let childID = child["id"] as? ID {
                children.append(childID)
            }
        }
        
        //ADD PARTNERS
        let partnersParsed = dictionary["partners"] as! NSArray
        for partner in partnersParsed {
            if let partner = partner as? NSDictionary, let partnerID = partner["id"] as? ID {
                spouses.append(partnerID)
            }
        }
        
    }
    
    func modelsFromDictionaryArray(array:NSArray) -> [Human]
    {
        var models:[Human] = []
        for item in array
        {
            models.append(Human(id: "", dictionary: item as! NSDictionary)!)
        }
        return models
    }
}


struct Patient {
    var id: ID = ""
    var row = 10
    var col = 10
    var mySpousesIDs: [ID] = []
    var myParentsIDs: [ID] = []
    var myChildrenIDs: [ID] = []
    var mySiblingsIDs: [ID] = []
    var fatherSiblingsIDs: [ID] = []
    var motherSiblingsIDs: [ID] = []
}

struct Model {
    static var minLevel = 1
    static var maxLevel = 1
    static var cell: [[ID]] = Array(repeating: Array(repeating: "", count: 20), count: 20)
}

class FamilyTree {
    var patient = Patient()
    var humans: [ID: Human] = [:]

    func printHuman(_ id: ID) {
        print("name:", humans[id]!.name)
        for spouseID in humans[id]!.spouses {
            print("spouse:", humans[spouseID]!.name)
        }
        for parentID in humans[id]!.parents {
            print("parent:", humans[parentID]!.name)
        }
        for childID in humans[id]!.children {
            print("child:", humans[childID]!.name)
        }
        for siblingID in humans[id]!.siblings {
            print("sibling:", humans[siblingID]!.name)
        }
        print("")
    }
    
    func makeTreeFor(_ id: ID) {
        let level = 1
        patient.id = id
        print("Family tree for", humans[id]!.name, "is on level", level)
        traverseTreeFor(id, level)
        print("minLevel=", Model.minLevel)
        print("maxLevel=", Model.maxLevel)
        print("")
    }
    
    func traverseTreeFor(_ id: ID, _ level: Int) {
        if humans[id]!.processed == false {
            humans[id]!.processed = true
            Model.maxLevel = max(Model.maxLevel, level)
            Model.minLevel = min(Model.minLevel, level)
            for spouseID in humans[id]!.spouses {
                print("spouse of", humans[id]!.name, "is", humans[spouseID]!.name, "on level", level)
                if id == patient.id {
                    patient.mySpousesIDs.append(spouseID)
                }
                traverseTreeFor(spouseID, level)
            }
            for parentID in humans[id]!.parents {
                print("parent of", humans[id]!.name, "is", humans[parentID]!.name, "on level", level - 1)
                if id == patient.id {
                    patient.myParentsIDs.append(parentID)
                }
                traverseTreeFor(parentID, level - 1)
            }
            for childID in humans[id]!.children {
                print("child of", humans[id]!.name, "is", humans[childID]!.name, "on level", level + 1)
                if id == patient.id {
                    patient.myChildrenIDs.append(childID)
                }
                traverseTreeFor(childID, level + 1)
            }
            for siblingID in humans[id]!.siblings {
                print("sibling of", humans[id]!.name, "is", humans[siblingID]!.name, "on level", level)
                if id == patient.id {
                    patient.mySiblingsIDs.append(siblingID)
                } else if patient.myParentsIDs.contains(id) {
                    if humans[id]!.gender == "M" {
                        patient.fatherSiblingsIDs.append(siblingID)
                    } else {
                        patient.motherSiblingsIDs.append(siblingID)
                    }
                }
                
                traverseTreeFor(siblingID, level)
            }
            
        }
    }
    
    func makeModelFromTree() {
        var row = patient.row
        var col = patient.col
        Model.cell[row][col] = patient.id
        col = patient.col - 1
        for id in patient.mySpousesIDs {
            //        Model.cell[row][col] = "--|--"
            col -= 1
            Model.cell[row][col] = id
        }
        row = patient.row
        col = patient.col
        for id in patient.mySiblingsIDs {
            col += 1
            Model.cell[row][col] = id
        }
        row = patient.row - 2
        for id in patient.myParentsIDs {
            if humans[id]!.gender == "M" {
                col = patient.col + 1
            } else {
                col = patient.col - 1
            }
            Model.cell[row][col] = id
        }
        row = patient.row - 2
        col = patient.col + 1
        for id in patient.fatherSiblingsIDs {
            col += 1
            Model.cell[row][col] = id
        }
        row = patient.row - 2
        col = patient.col - 1
        for id in patient.motherSiblingsIDs {
            col -= 1
            Model.cell[row][col] = id
        }
        row = patient.row + 2
        col = patient.col - 2
        for id in patient.myChildrenIDs {
            col += 1
            Model.cell[row][col] = id
        }
    }
    
    func addSpouseFor(_ id: ID, spouse: ID) {
        humans[id]!.spouses.append(spouse)
    }
    
    func addParentFor(_ id: ID, parent: ID) {
        humans[id]!.parents.append(parent)
    }
    
    func addChildFor(_ id: ID, child: ID) {
        humans[id]!.children.append(child)
    }
    
    func addSiblingFor(_ id: ID, sibling: ID) {
        humans[id]!.siblings.append(sibling)
    }
    
    func fillFamilyTreeFor(patientID: ID, family: [ID:Human]) {
        humans = family
        for (id , human) in family {
            print(patientID)
            print(human.id)
            print(id)
            
            for parentID in human.parents {
                addParentFor(id, parent: parentID)
            }
            
            for spouseID in human.spouses {
                addSpouseFor(id, spouse: spouseID)
            }
            
            for childID in human.children {
                addChildFor(id, child: childID)
            }
            
            for siblingID in human.siblings {
                addSiblingFor(id, sibling: siblingID)
            }
        }
        
        
    humans["Ton"] = Human(name: "Ton", gender: "M")
    humans["Dorine"] = Human(name: "Dorine", gender: "F")
    humans["Tim"] = Human(name: "Tim", gender: "M")
    humans["Iris"] = Human(name: "Iris", gender: "F")
    humans["Frans"] = Human(name: "Frans", gender: "M")
    humans["Dora"] = Human(name: "Dora", gender: "F")
    humans["Rianne"] = Human(name: "Rianne", gender: "F")
    humans["Annemieke"] = Human(name: "Annemieke", gender: "F")
    humans["Ad"] = Human(name: "Ad", gender: "M")
    humans["Willy"] = Human(name: "Willy", gender: "M")
    humans["Tiny"] = Human(name: "Tiny", gender: "M")
    humans["Toos"] = Human(name: "Toos", gender: "F")
    humans["Mien"] = Human(name: "Mien", gender: "F")

    addSpouseFor("Ton", spouse: "Dorine")
    addChildFor("Ton", child: "Tim")
    addChildFor("Ton", child: "Iris")
    addParentFor("Ton", parent: "Frans")
    addParentFor("Ton", parent: "Dora")
    addSiblingFor("Ton", sibling: "Rianne")
    addSiblingFor("Ton", sibling: "Annemieke")

    addSpouseFor("Dorine", spouse: "Ton")
    addChildFor("Dorine", child: "Tim")
    addChildFor("Dorine", child: "Iris")

    addParentFor("Tim", parent: "Ton")
    addSiblingFor("Tim", sibling: "Iris")

    addParentFor("Iris", parent: "Ton")
    addSiblingFor("Iris", sibling: "Tim")

    addSpouseFor("Frans", spouse: "Dora")
    addChildFor("Frans", child: "Ton")
    addChildFor("Frans", child: "Rianne")
    addChildFor("Frans", child: "Annemieke")
    addSiblingFor("Frans", sibling: "Ad")
    addSiblingFor("Frans", sibling: "Willy")
    addSiblingFor("Frans", sibling: "Tiny")
    addSiblingFor("Frans", sibling: "Toos")
    addSiblingFor("Frans", sibling: "Mien")

    addSiblingFor("Ad", sibling: "Frans")
    addSiblingFor("Ad", sibling: "Willy")
    addSiblingFor("Ad", sibling: "Tiny")
    addSiblingFor("Ad", sibling: "Toos")
    addSiblingFor("Ad", sibling: "Mien")

    addSiblingFor("Willy", sibling: "Ad")
    addSiblingFor("Willy", sibling: "Frans")
    addSiblingFor("Willy", sibling: "Tiny")
    addSiblingFor("Willy", sibling: "Toos")
    addSiblingFor("Willy", sibling: "Mien")

    addSiblingFor("Tiny", sibling: "Ad")
    addSiblingFor("Tiny", sibling: "Willy")
    addSiblingFor("Tiny", sibling: "Frans")
    addSiblingFor("Tiny", sibling: "Toos")
    addSiblingFor("Tiny", sibling: "Mien")

    addSiblingFor("Toos", sibling: "Ad")
    addSiblingFor("Toos", sibling: "Willy")
    addSiblingFor("Toos", sibling: "Tiny")
    addSiblingFor("Toos", sibling: "Frans")
    addSiblingFor("Toos", sibling: "Mien")

    addSiblingFor("Mien", sibling: "Ad")
    addSiblingFor("Mien", sibling: "Willy")
    addSiblingFor("Mien", sibling: "Tiny")
    addSiblingFor("Mien", sibling: "Toos")
    addSiblingFor("Mien", sibling: "Frans")

    addSpouseFor("Dora", spouse: "Frans")
    addChildFor("Dora", child: "Ton")
    addChildFor("Dora", child: "Rianne")
    addChildFor("Dora", child: "Annemieke")
    
    addParentFor("Rianne", parent: "Frans")
    addParentFor("Rianne", parent: "Dora")
    addSiblingFor("Rianne", sibling: "Ton")
    addSiblingFor("Rianne", sibling: "Annemieke")
    
    addParentFor("Annemieke", parent: "Frans")
    addParentFor("Annemieke", parent: "Dora")
    addSiblingFor("Annemieke", sibling: "Ton")
    addSiblingFor("Annemieke", sibling: "Rianne")
        //
        makeTreeFor("Ton")
        
        for id in patient.myParentsIDs {
            print("myParentsIDs", id)
        }
        for id in patient.fatherSiblingsIDs {
            print("fatherSiblingsIDs", id)
        }
        for id in patient.motherSiblingsIDs {
            print("motherSiblingsIDs", id)
        }
        for id in patient.mySpousesIDs {
            print("mySpousesIDs", id)
        }
        for id in patient.mySiblingsIDs {
            print("mySiblingsIDs", id)
        }
        for id in patient.myChildrenIDs {
            print("myChildrenIDs", id)
        }
        print("")
        
        makeModelFromTree()
        
        for i in patient.row - 2 ... patient.row + 2 {
            for j in 0 ... 19 {
                print(Model.cell[i][j], " ", terminator: "")
            }
            print("")
        }
        
    }
}
