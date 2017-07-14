import Foundation

class FamilyTreeGenerator {
    var patient: Patient = Patient(id: "")
    var familyTree: [ID: Human] = [:]
    var diseases: [ID: Disease] = [:]
    var model: Model?
    
    init(familyTree: [ID: Human]) {
        self.familyTree = familyTree
        self.model = Model.init()
    }
    
    init(diseases: [ID: Disease]) {
        self.diseases = diseases
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
            
            func createSpouseArray(){
                for spouseID in familyTree[id]!.spouses {
                    print("spouse of", familyTree[id]!.name, "is", familyTree[spouseID]!.name, "on level", level)
                    if id == patient.id {
                        patient.mySpousesIDs.append(spouseID)
                    }
                    traverseTreeFor(spouseID, level)
                }
            }
            
            //******************************
            func createGrandparentArray() {
                for grandparentID in familyTree[id]!.grandparents {
                    print("grandparent of", familyTree[id]!.name, "is", familyTree[grandparentID]!.name, "on level", level - 1)
                    if id == patient.id {
                        patient.myGrandparentsIDs.append(grandparentID)
                    }
                    traverseTreeFor(grandparentID, level - 1)
                }
            }
            
            
            func createParentArray() {
                for parentID in familyTree[id]!.parents {
                    print("parent of", familyTree[id]!.name, "is", familyTree[parentID]!.name, "on level", level - 1)
                    if id == patient.id {
                        patient.myParentsIDs.append(parentID)
                    }
                    traverseTreeFor(parentID, level - 1)
                }
            }
            
            func createChildArray(){
                for childID in familyTree[id]!.children {
                    print("child of", familyTree[id]!.name, "is", familyTree[childID]!.name, "on level", level + 1)
                    if id == patient.id {
                        patient.myChildrenIDs.append(childID)
                    }
                    traverseTreeFor(childID, level + 1)
                }
            }
            
            
            func createSiblingArrays(){
                for siblingID in familyTree[id]!.siblings {
                    print("sibling of", familyTree[id]!.name, "is", familyTree[siblingID]!.name, "on level", level)
                    if id == patient.id {
                        patient.mySiblingsIDs.append(siblingID)
                    } else if (familyTree[patient.id!]?.parents.contains(id))!{
                        if familyTree[id]!.gender == JsonKeys.male.rawValue {
                            patient.fatherSiblingsIDs.append(siblingID)
                        } else {
                            patient.motherSiblingsIDs.append(siblingID)
                        }
                    }
                    traverseTreeFor(siblingID, level)
                }
            }
            
            createSpouseArray()
            
            createParentArray()
            
            createChildArray()
            
            createSiblingArrays()
            
        }
    }
    
    //  functions for populating the Model structure
    //  Model is a 2D matrix for building the family tree and connecting the nodes
    //  we build this from the Patient structure
    
    
    func makeModelFromTree() {
        
        var row = patient.row
        var col = patient.col
        
        func setDrawingPoints(rowX: Int, colY: Int) {
            row = patient.row + rowX
            col = patient.col + colY
        }
        
        func setDrawingPointY(colY: Int) {
            col = patient.col + colY
        }
        
        func setDrawingPointX(rowX: Int) {
            row = patient.row + rowX
        }
        
        func addSiblings() {
            for id in patient.mySiblingsIDs {
                col += 1
                
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    model?.cell?[row][col] = cellState.brother(id: id)
                } else {
                    model?.cell?[row][col] = cellState.sister(id: id)
                }
                
                if id == patient.mySiblingsIDs.last {
                    model?.cell?[row - 1][col] = cellState.cornerLeftBottom
                } else {
                    model?.cell?[row - 1][col] = cellState.spouseConnector
                }
            }
        }
        
        func addFatherSiblings() {
            for id in patient.fatherSiblingsIDs {
                col += 1
                
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    model?.cell?[row][col] = cellState.brother(id: id)
                } else {
                    model?.cell?[row][col] = cellState.sister(id: id)
                }
                
                model?.cell?[row - 1][patient.col + 1] = cellState.cornerRightBottom
                
                if id == patient.fatherSiblingsIDs.last {
                    model?.cell?[row - 1][col] = cellState.cornerLeftBottom
                } else {
                    model?.cell?[row - 1][col] = cellState.spouseConnector
                }
            }
        }
        
        func addMotherSiblings() {
            for id in patient.motherSiblingsIDs {
                col -= 1
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    model?.cell?[row][col] = cellState.brother(id: id)
                } else {
                    model?.cell?[row][col] = cellState.sister(id: id)
                }
                
                model?.cell?[row - 1][patient.col - 1] = cellState.cornerLeftBottom
                if id == patient.motherSiblingsIDs.last {
                    model?.cell?[row - 1][col] = cellState.cornerRightBottom
                } else {
                    model?.cell?[row - 1][col] = cellState.spouseConnector
                }
            }
        }
        
        func addChilderen() {
            for id in patient.myChildrenIDs {
                col += 1
                
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    model?.cell?[row][col] = cellState.brother(id: id)
                } else {
                    model?.cell?[row][col] = cellState.sister(id: id)
                }
                
                if id == patient.myChildrenIDs.last {
                    model?.cell?[row - 1][col] = cellState.cornerLeftBottom
                } else {
                    model?.cell?[row - 1][col] = cellState.spouseConnector
                }
            }
        }
        
        func childerenParentConnectors() {
            if patient.myParentsIDs.count > 0 {
                model?.cell?[row][col] = cellState.spouseConnector
                
                if patient.mySiblingsIDs.count > 0 {
                    model?.cell?[row + 1][col] = cellState.patientParentConnector
                } else {
                    model?.cell?[row + 1][col] = cellState.straightVertical
                }
            }
        }
        
        func addParents(){
            
            for id in patient.myParentsIDs {
                
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    if patient.fatherSiblingsIDs.count > 0 {
                        model?.cell?[row][col + 1] = cellState.malePatient(id: id)
                    } else {
                        model?.cell?[row][col + 1] = cellState.father(id: id)
                    }
                }
                
                if familyTree[id]!.gender != JsonKeys.male.rawValue {
                    if patient.motherSiblingsIDs.count > 0 {
                        model?.cell?[row][col - 1] = cellState.motherWithSiblings(id: id)
                    } else {
                        model?.cell?[row][col - 1] = cellState.mother(id: id)
                    }
                }
                
            }
        }
        
        func spouseConnector() {
            for id in patient.mySpousesIDs {
                model?.cell?[row][col] = cellState.spouseConnector
                col -= 1
                
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    model?.cell?[row][col] = cellState.maleSpouse(id: id)
                } else {
                    model?.cell?[row][col] = cellState.femaleSpouse(id: id)
                }
                
            }
        }
        
        func drawPatient() {
            if let patientID = patient.id {
                
                if familyTree[patientID]?.gender == JsonKeys.male.rawValue {
                    
                    if patient.mySpousesIDs.count > 0 {
                        model?.cell?[row][col] = cellState.malePatient(id: patientID)
                    } else {
                        model?.cell?[row][col] = cellState.brother(id: patientID)
                    }
                }
                
                if familyTree[patientID]?.gender != JsonKeys.male.rawValue {
                    
                    if patient.mySpousesIDs.count > 0 {
                        model?.cell?[row][col] = cellState.femalePatient(id: patientID)
                    } else {
                        model?.cell?[row][col] = cellState.sister(id: patientID)
                    }
                }
            }
        }
        
        func childerenPatientConnector() {
            if patient.myChildrenIDs.count == 1 {
                model?.cell?[row - 1][patient.col - 1] = cellState.straightVertical
            } else {
                if patient.myChildrenIDs.count > 0 {
                    model?.cell?[row - 1][patient.col - 1] = cellState.patientParentConnector
                }
            }
        }
        
        if let patientID = patient.id {
            
            drawPatient()
            
            setDrawingPointY(colY: -1)
            
            spouseConnector()
            
            setDrawingPoints(rowX: 0, colY: 0)
            
            addSiblings()
            
            setDrawingPoints(rowX: -2, colY: 0)
            
            addParents()
            
            childerenParentConnectors()
            
            setDrawingPoints(rowX: -2, colY: 1)
            
            addFatherSiblings()
            
            setDrawingPoints(rowX: -2, colY: -1)
            
            addMotherSiblings()
            
            setDrawingPoints(rowX: 2, colY: -2)
            
            addChilderen()
            
            childerenPatientConnector()
        }
        
    }
    
}
