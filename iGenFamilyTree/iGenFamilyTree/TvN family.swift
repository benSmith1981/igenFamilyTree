import Foundation

typealias ID = String

struct Human {
    var name: String
    var processed: Bool = false
    var spouses: [ID] = []
    var parents: [ID] = []
    var children: [ID] = []
    var siblings: [ID] = []
    
    init(name: String) {
        self.name = name
    }
}

var humans: [ID: Human] = [:]

//var row: [Int] = []
//var column: [Int] = []

struct Model {
    static var minLevel = 0
    static var maxLevel = 0
    static var cell: [[ID]] = Array(repeating: Array(repeating: "", count: 10), count: 10)
    //    static var cell: [[ID]] = [[]]
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

func makeTreeFor(_ id: ID, _ level: Int = 5) {
    print("Family tree for", humans[id]!.name, "is on level", level)
    fillModelFor(id, level: level)
    traverseTreeFor(id, level)
    print("minLevel=", Model.minLevel)
    print("maxLevel=", Model.maxLevel)
}

func traverseTreeFor(_ id: ID, _ level: Int) {
    humans[id]!.processed = true
    Model.maxLevel = max(Model.maxLevel, level)
    Model.minLevel = min(Model.minLevel, level)
    for spouseID in humans[id]!.spouses {
        if humans[spouseID]!.processed == false {
            print("spouse of", humans[id]!.name, "is", humans[spouseID]!.name, "on level", level)
            fillModelFor(spouseID, level: level)
            traverseTreeFor(spouseID, level)
        }
    }
    for parentID in humans[id]!.parents {
        if humans[parentID]!.processed == false {
            print("parent of", humans[id]!.name, "is", humans[parentID]!.name, "on level", level + 1)
            fillModelFor(parentID, level: level + 1)
            traverseTreeFor(parentID, level + 1)
        }
    }
    for childID in humans[id]!.children {
        if humans[childID]!.processed == false {
            print("child of", humans[id]!.name, "is", humans[childID]!.name, "on level", level - 1)
            fillModelFor(childID, level: level - 1)
            traverseTreeFor(childID, level - 1)
        }
    }
    for siblingID in humans[id]!.siblings {
        if humans[siblingID]!.processed == false {
            print("sibling of", humans[id]!.name, "is", humans[siblingID]!.name, "on level", level)
            fillModelFor(siblingID, level: level)
            traverseTreeFor(siblingID, level)
        }
    }
}

func fillModelFor(_ id: ID, level: Int) {
    for i in 0 ... 9 {
        if Model.cell[level][i] == "" {
            Model.cell[level][i] = id
            break
        }
    }
}

//    func findParents(_ level: Int = 1) {
//        for parent in parents {
//            print("parent of", self.name, "is", parent.name, "on level", level)
//            parent.findParents(level + 1)
//        }
//    }
//
//    func findChildren(_ level: Int = 1) {
//        for child in children {
//            print("child of", self.name, "is", child.name, "on level", level)
//            child.findChildren(level + 1)
//        }
//    }

func fillFamilyTreeFor(_ id: ID) {
    humans["Ton"] = Human(name: "Ton")
    humans["Dorine"] = Human(name: "Dorine")
    humans["Tim"] = Human(name: "Tim")
    humans["Iris"] = Human(name: "Iris")
    humans["Wim"] = Human(name: "Wim")
    humans["An"] = Human(name: "An")
    humans["Frans"] = Human(name: "Frans")
    humans["Dora"] = Human(name: "Dora")
    humans["Mike"] = Human(name: "Mike")
    humans["Rianne"] = Human(name: "Rianne")
    humans["Annemieke"] = Human(name: "Annemieke")
    
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
    addParentFor("Dorine", parent: "Wim")
    addParentFor("Dorine", parent: "An")
    addSiblingFor("Dorine", sibling: "Mike")
    
    addParentFor("Tim", parent: "Ton")
    addParentFor("Tim", parent: "Dorine")
    addSiblingFor("Tim", sibling: "Iris")
    
    addParentFor("Iris", parent: "Ton")
    addParentFor("Iris", parent: "Dorine")
    addSiblingFor("Iris", sibling: "Tim")
    
    addSpouseFor("Wim", spouse: "An")
    addChildFor("Wim", child: "Dorine")
    addChildFor("Wim", child: "Mike")
    
    addSpouseFor("An", spouse: "Wim")
    addChildFor("An", child: "Dorine")
    addChildFor("An", child: "Mike")
    
    addSpouseFor("Frans", spouse: "Dora")
    addChildFor("Frans", child: "Ton")
    addChildFor("Frans", child: "Rianne")
    addChildFor("Frans", child: "Annemieke")
    
    addSpouseFor("Dora", spouse: "Frans")
    addChildFor("Dora", child: "Ton")
    addChildFor("Dora", child: "Rianne")
    addChildFor("Dora", child: "Annemieke")
    
    addParentFor("Mike", parent: "Wim")
    addParentFor("Mike", parent: "An")
    addSiblingFor("Mike", sibling: "Dorine")
    
    addParentFor("Rianne", parent: "Frans")
    addParentFor("Rianne", parent: "Dora")
    addSiblingFor("Rianne", sibling: "Ton")
    addSiblingFor("Rianne", sibling: "Annemieke")
    
    addParentFor("Annemieke", parent: "Frans")
    addParentFor("Annemieke", parent: "Dora")
    addSiblingFor("Annemieke", sibling: "Ton")
    addSiblingFor("Annemieke", sibling: "Rianne")
    
    makeTreeFor(id)
    
    for i in (Model.minLevel ... Model.maxLevel).reversed() {
        for j in 0 ... 9 {
            print(Model.cell[i][j], " ", terminator: "")
        }
        print("")
    }
    
}

//fillFamilyTreeFor("Ton")
