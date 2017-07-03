import Foundation

class FamilyTree {
    var patient = Patient()
    var humans: [ID: Human] = [:]

    var tests: FamilyTreeTests?

    //  functions for populating the Patient structure by calling function traverseTreeFor,
    //  which is then again called recursively for every human
    //  it also calculates the minimum and maximum levels traversed
    //  for processing siblings we need to test for siblings of the Patient or siblings of the father or mother of the Patient
    
    func makeTreeFor(_ id: ID) {
        let level = 1
        patient.id = id
        print("Family tree for", humans[id]!.name, "is on level", level)
        traverseTreeFor(id, level)
        print("minLevel=", Model.minLevel)
        print("maxLevel=", Model.maxLevel)
        print("")
    }
    
    private func traverseTreeFor(_ id: ID, _ level: Int) {
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
                } else if humans[Patient.id]!.parents.contains(id) {
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

    //  functions for populating the Model structure
    //  Model is a 2D matrix for building the family tree and connecting the nodes
    //  we build this from the Patient structure

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
    
    }
}
