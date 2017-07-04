import Foundation

class FamilyTreeGenerator {
    var patient: Patient = Patient(id: "")
    var familyTree: [ID: Human] = [:]
//    var patientID: ID = ""
    var model: Model?
    
    init(familyTree: [ID: Human]) {
        self.familyTree = familyTree
        self.model = Model.init()
    }
    
    //  functions for populating the Patient structure by calling function traverseTreeFor,
    //  which is then again called recursively for every human
    //  it also calculates the minimum and maximum levels traversed
    //  for processing siblings we need to test for siblings of the Patient or siblings of the father or mother of the Patient
    
    func makeTreeFor(_ id: ID) {
        self.patient = Patient.init(id: id)
        let level = 1
        print("Family tree for", familyTree[id]!.name, "is on level", level)
        traverseTreeFor(id, level)
        print("minLevel=", model?.minLevel)
        print("maxLevel=", model?.maxLevel)
        print("")
    }
    
    func traverseTreeFor(_ id: ID, _ level: Int) {
        if familyTree[id]!.processed == false {
            familyTree[id]!.processed = true
            model?.maxLevel = max((model?.maxLevel)!, level)
            model?.minLevel = min((model?.minLevel)!, level)
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
                    if familyTree[id]!.gender == "male" {
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
        model?.cell?[row][col] = patient.id!
        col = patient.col - 1
        for id in patient.mySpousesIDs {
            model?.cell?[row][col] = "---,---"
            col -= 1
            model?.cell?[row][col] = id
        }
        row = patient.row
        col = patient.col
        for id in patient.mySiblingsIDs {
            col += 1
            model?.cell?[row][col] = id
            model?.cell?[row - 1][patient.col] = "|--"
            if id == patient.mySiblingsIDs.last {
                model?.cell?[row - 1][col] = "--,"
            } else {
                model?.cell?[row - 1][col] = "-------"
            }
        }
        row = patient.row - 2
        col = patient.col
        for id in patient.myParentsIDs {
            if familyTree[id]!.gender == "male" {
                model?.cell?[row][col + 1] = id
            } else {
                model?.cell?[row][col - 1] = id
            }
        }
        if patient.myParentsIDs.count > 0 {
            model?.cell?[row][col] = "---,---"
            model?.cell?[row + 1][col] = "  |  "
        }
        row = patient.row - 2
        col = patient.col + 1
        for id in patient.fatherSiblingsIDs {
            col += 1
            model?.cell?[row][col] = id
            model?.cell?[row - 1][patient.col + 1] = ",--"
            if id == patient.fatherSiblingsIDs.last {
                model?.cell?[row - 1][col] = "--,"
            } else {
                model?.cell?[row - 1][col] = "-------"
            }
        }
        row = patient.row - 2
        col = patient.col - 1
        for id in patient.motherSiblingsIDs {
            col -= 1
            model?.cell?[row][col] = id
            model?.cell?[row - 1][patient.col - 1] = "--,"
            if id == patient.motherSiblingsIDs.last {
                model?.cell?[row - 1][col] = ",--"
            } else {
                model?.cell?[row - 1][col] = "-------"
            }
        }
        row = patient.row + 2
        col = patient.col - 2
        for id in patient.myChildrenIDs {
            col += 1
            model?.cell?[row][col] = id
            if id == patient.myChildrenIDs.last {
                model?.cell?[row - 1][col] = "--,"
            } else {
                model?.cell?[row - 1][col] = "-------"
            }
        }
        if patient.myChildrenIDs.count == 1 {
            model?.cell?[row - 1][patient.col - 1] = "  |  "
        } else {
            if patient.myChildrenIDs.count > 0 {
                model?.cell?[row - 1][patient.col - 1] = "|--"
            }
        }
    }
    
}
