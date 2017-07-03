import Foundation

class FamilyTree {
    var patient: Patient = Patient(id: "")
    var familyTree: [ID: Human] = [:]
    var patientID: ID = ""

    init(familyTree: [ID: Human]) {
        self.familyTree = familyTree
    }
    
    func makeTreeFor(_ id: ID) {
        self.patient = Patient.init(id: id)
        let level = 1
        print("Family tree for", familyTree[id]!.name, "is on level", level)
        traverseTreeFor(id, level)
        print("minLevel=", Model.minLevel)
        print("maxLevel=", Model.maxLevel)
        print("")
    }
    
    func traverseTreeFor(_ id: ID, _ level: Int) {
        if familyTree[id]!.processed == false {
            familyTree[id]!.processed = true
            Model.maxLevel = max(Model.maxLevel, level)
            Model.minLevel = min(Model.minLevel, level)
            for spouseID in familyTree[id]!.spouses {
                print("spouse of", familyTree[id]!.name, "is", familyTree[spouseID]!.name, "on level", level)
                if id == patient.id {
                    patient.mySpousesIDs.append(spouseID)
                }
                traverseTreeFor(spouseID, level)
            }
            for parentID in familyTree[id]!.parents {
                print("parent of", familyTree[id]!.name, "is", familyTree[parentID]!.name, "on level", level - 1)
                if id == patient.id {
                    patient.myParentsIDs.append(parentID)
                }
                traverseTreeFor(parentID, level - 1)
            }
            for childID in familyTree[id]!.children {
                print("child of", familyTree[id]!.name, "is", familyTree[childID]!.name, "on level", level + 1)
                if id == patient.id {
                    patient.myChildrenIDs.append(childID)
                }
                traverseTreeFor(childID, level + 1)
            }
            for siblingID in familyTree[id]!.siblings {
                print("sibling of", familyTree[id]!.name, "is", familyTree[siblingID]!.name, "on level", level)
                if id == patient.id {
                    patient.mySiblingsIDs.append(siblingID)
                } else if (familyTree[patient.id!]?.parents.contains(id))!{
                    if familyTree[id]!.gender == "M" {
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
        Model.cell[row][col] = patient.id!
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
            if familyTree[id]!.gender == "M" {
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
        familyTree[id]!.spouses.append(spouse)
    }
    
    func addParentFor(_ id: ID, parent: ID) {
        familyTree[id]!.parents.append(parent)
    }
    
    func addChildFor(_ id: ID, child: ID) {
        familyTree[id]!.children.append(child)
    }
    
    func addSiblingFor(_ id: ID, sibling: ID) {
        familyTree[id]!.siblings.append(sibling)
    }
    
    func fillFamilyTreeFor() {
        for (id , human) in familyTree {
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
