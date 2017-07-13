import Foundation

class FamilyTreeGenerator {
    var patient: Patient = Patient(id: "")
    var familyTree: [ID: Human] = [:]
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
            
            func createSpouseArray(){
                for spouseID in familyTree[id]!.spouses {
                    print("spouse of", familyTree[id]!.name, "is", familyTree[spouseID]!.name, "on level", level)
                    if id == patient.id {
                        patient.mySpousesIDs.append(spouseID)
                    }
                    traverseTreeFor(spouseID, level)
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
        var placementCounter: Int = 0
        
        func setDrawingPoints(rowX: Int, colY: Int) {
            row = patient.row + rowX
            col = patient.col + colY
        }
        
        func setDrawingPointsRelative(rowX: Int, colY: Int){
            row = row + rowX
            col = col + colY
        }
        
        func setDrawingPointY(colY: Int) {
            col = patient.col + colY
        }
        
        func setDrawingPointX(rowX: Int) {
            row = patient.row + rowX
        }
        
        func addSiblings() {
            
            col = col + 1
            
            var even = col
            var uneven = col - 1
            
            if patient.mySiblingsIDs.count % 2 != 0 {
                uneven = col - 2
            }
            
            for (index, id) in patient.mySiblingsIDs.enumerated() {
                
                if index % 2 == 0 {
                    print("even")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][even] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][even] = cellState.sister(id: id)
                    }
                    
                    if id == patient.mySiblingsIDs.last || index == patient.mySiblingsIDs.count - 2 {
                        model?.cell?[row - 1][even] = cellState.cornerLeftBottom
                    } else {
                        model?.cell?[row - 1][even] = cellState.spouseConnector
                    }
                    
                    even += 1
                    
                } else {
                    print("uneven")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][uneven] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][uneven] = cellState.sister(id: id)
                    }
                    
                    model?.cell?[row - 1][uneven] = cellState.spouseConnector
                    
                    uneven -= 1
                    
                }
                
            }
        }
        
        // SPACING , CONNECTORS & PLACEMENT COUNTER NEED TO BE SORTED OUT
        func addFatherSiblings() {
            
            col = col + 1
            
            var even = col
            var uneven = col - 1
            
            if patient.fatherSiblingsIDs.count % 2 != 0 {
                uneven = col - 2
            }
            
            for (index, id) in patient.fatherSiblingsIDs.enumerated() {
                
                if index % 2 == 0 {
                    print("even")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][even] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][even] = cellState.sister(id: id)
                    }
                    
                    if id == patient.fatherSiblingsIDs.last || index == patient.fatherSiblingsIDs.count - 2 {
                        model?.cell?[row - 1][even] = cellState.cornerLeftBottom
                    } else {
                        model?.cell?[row - 1][even] = cellState.spouseConnector
                    }
                    
                    even += 1
                    
                } else {
                    print("uneven")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][uneven] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][uneven] = cellState.sister(id: id)
                    }
                    
                    model?.cell?[row - 1][uneven] = cellState.spouseConnector
                    
                    uneven -= 1
                    
                }
            }
        }
        
        // SPACING , CONNECTORS & PLACEMENT COUNTER NEED TO BE SORTED OUT
        func addMotherSiblings() {
            
            
            //col = col - 1
            
            var even = col - 1
            var uneven = col
            
            if patient.motherSiblingsIDs.count % 2 != 0 {
                uneven = col + 1
            }
            
            for (index, id) in patient.motherSiblingsIDs.enumerated() {
                
                if index % 2 == 0 {
                    print("even")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][even] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][even] = cellState.sister(id: id)
                    }
                    
                    if id == patient.motherSiblingsIDs.last || index == patient.motherSiblingsIDs.count - 2 {
                        model?.cell?[row - 1][even] = cellState.cornerRightBottom
                    } else {
                        model?.cell?[row - 1][even] = cellState.spouseConnector
                    }
                    
                    even -= 1
                    
                } else {
                    print("uneven")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][uneven] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][uneven] = cellState.sister(id: id)
                    }
                    
                    model?.cell?[row - 1][uneven] = cellState.spouseConnector
                    
                    uneven += 1
                    
                }
                
            }
            
        }
        
        func addChilderen() {
            
            col = col + 1
            var even = col
            var uneven = col - 1
            
            if patient.myChildrenIDs.count % 2 == 0 {
                even = col + 1
            }
            
            for (index, id) in patient.myChildrenIDs.enumerated() {
                
                if index % 2 == 0 {
                    print("even")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][even] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][even] = cellState.sister(id: id)
                    }
                    
                    if id == patient.myChildrenIDs.last || index == patient.myChildrenIDs.count - 2 {
                        model?.cell?[row - 1][even] = cellState.cornerLeftBottom
                    } else {
                        model?.cell?[row - 1][even] = cellState.spouseConnector
                    }
                    
                    even += 1
                    
                } else {
                    print("uneven")
                    if familyTree[id]!.gender == JsonKeys.male.rawValue {
                        model?.cell?[row][uneven] = cellState.brother(id: id)
                    } else {
                        model?.cell?[row][uneven] = cellState.sister(id: id)
                    }
                    
                    if id == patient.myChildrenIDs.last || index == patient.myChildrenIDs.count - 2 {
                        model?.cell?[row - 1][uneven] = cellState.cornerRightBottom
                    } else {
                        model?.cell?[row - 1][uneven] = cellState.spouseConnector
                    }
                    
                    uneven -= 1
                    
                }
                
                
                
            }
        }
        
        func placementPatientParentConnector() {
            
            placementCounter = 0
            
            if patient.mySiblingsIDs.count == 0 {
                placementCounter = 1
            }
            
            for (index, id) in patient.mySiblingsIDs.enumerated() {
                
                if index % 2 == 0 {
                    placementCounter += 1
                }
            }
        }
        
        func patientParentConnectors() {
            if patient.myParentsIDs.count > 0 {
                model?.cell?[row][col] = cellState.spouseConnector
                
                if patient.mySiblingsIDs.count % 2 != 0 && patient.mySiblingsIDs.count > 0 {
                    model?.cell?[row + 1][col] = cellState.twoChilderenConnector
                } else if patient.mySiblingsIDs.count % 2 == 0 && patient.mySiblingsIDs.count > 0 {
                    model?.cell?[row + 1][col] = cellState.threeChilderenConnector
                } else {
                    model?.cell?[row + 1][col] = cellState.cornerLeftTop
                }
            }
        }
        
        func placementConnectorFatherGrandparents() {
            
            if patient.fatherSiblingsIDs.count == 0 {
                placementCounter = 1
            }
            
            for (index, id) in patient.fatherSiblingsIDs.enumerated() {
                
                if index % 2 == 0 {
                    placementCounter += 1
                }
            }
        }
        
        func placementConnectorMotherGrandparents() {
            
            placementCounter = 0
            
            if patient.motherSiblingsIDs.count == 0 {
                placementCounter = -1
            }
            
            for (index, id) in patient.motherSiblingsIDs.enumerated() {
                
                if index % 2 == 0 {
                    placementCounter -= 1
                }
            }
        }
        
        func motherGrandparentConnectors() {
            if patient.myParentsIDs.count > 0 {   // >>>>>>>>>>>>>>>>>> NO GRAND PARENTS COUNTER YET FOR THIS COUNTER --
                model?.cell?[row][col] = cellState.spouseConnector
                
                if patient.motherSiblingsIDs.count % 2 != 0 && patient.motherSiblingsIDs.count > 0 {
                    model?.cell?[row + 1][col] = cellState.twoChilderenConnector
                } else if patient.motherSiblingsIDs.count % 2 == 0 && patient.motherSiblingsIDs.count > 0 {
                    model?.cell?[row + 1][col] = cellState.threeChilderenConnector
                } else {
                    model?.cell?[row + 1][col] = cellState.cornerLeftTop
                }
            }
        }
        
        func fatherGrandparentConnectors() {
            if patient.myParentsIDs.count > 0 {   // >>>>>>>>>>>>>>>>>> NO GRAND PARENTS COUNTER YET FOR THIS COUNTER --
                model?.cell?[row][col] = cellState.spouseConnector
                
                if patient.fatherSiblingsIDs.count % 2 != 0 && patient.fatherSiblingsIDs.count > 0 {
                    model?.cell?[row + 1][col] = cellState.twoChilderenConnector
                } else if patient.fatherSiblingsIDs.count % 2 == 0 && patient.fatherSiblingsIDs.count > 0 {
                    model?.cell?[row + 1][col] = cellState.threeChilderenConnector
                } else {
                    model?.cell?[row + 1][col] = cellState.cornerLeftTop
                }
            }
        }
        
        func addParents(){
            
            for id in patient.myParentsIDs {
                
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    if patient.fatherSiblingsIDs.count > 0 {
                        model?.cell?[row][col + 1] = cellState.malePatient(id: id)
                        model?.cell?[row - 1][col + 1] = cellState.cornerRightBottom
                    } else {
                        model?.cell?[row][col + 1] = cellState.father(id: id)
                    }
                }
                
                if familyTree[id]!.gender != JsonKeys.male.rawValue {
                    if patient.motherSiblingsIDs.count > 0 {
                        model?.cell?[row][col - 1] = cellState.motherWithSiblings(id: id)
                        model?.cell?[row - 1][col - 1] = cellState.cornerLeftBottom
                    } else {
                        model?.cell?[row][col - 1] = cellState.mother(id: id)
                    }
                }
                
            }
        }
        
        func spouseConnector() {
            for id in patient.mySpousesIDs {
                
                if patient.myChildrenIDs.count > 0 {
                    model?.cell?[row][col] = cellState.spouseConnector
                } else {
                    model?.cell?[row][col] = cellState.straightHorizontal
                }
                
                
                col -= 1
                
                if familyTree[id]!.gender == JsonKeys.male.rawValue {
                    model?.cell?[row][col] = cellState.maleSpouse(id: id)
                } else {
                    model?.cell?[row][col] = cellState.femaleSpouse(id: id)
                }
                
            }
        }
        
        func drawRightBottomCorner(){
            model?.cell?[row][col] = cellState.cornerRightBottom
        }
        
        func drawLeftBottomCorner(){
            model?.cell?[row][col] = cellState.cornerLeftBottom
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
            
            guard patient.myChildrenIDs.count > 0 else {
                print("no childeren found for Patient")
                return
            }
            
            if patient.myChildrenIDs.count == 1 {
                model?.cell?[row - 1][patient.col - 1] = cellState.straightVertical
            } else if patient.myChildrenIDs.count % 2 == 0 {
                model?.cell?[row - 1][patient.col - 1] = cellState.twoChilderenConnector
            } else {
                model?.cell?[row - 1][patient.col - 1] = cellState.threeChilderenConnector
            }
            
            
        }
        
        if let patientID = patient.id {
            
            drawPatient() //1 Draw patient
            
            setDrawingPointY(colY: -1) //2 Go one to the left
            
            spouseConnector() //3 Draw connections between patient and spouse
            
            setDrawingPoints(rowX: -1, colY: 0) //4 Go to cell above patient
            
            drawRightBottomCorner() // 4.1 Draw corner RightToBottom (/)
            
            placementPatientParentConnector() // Determine the middle of patient and siblings (1sib = +1, 3sib = +2..)
            
            setDrawingPoints(rowX: 0, colY: placementCounter) //4 Go to patient row and middle cell
            
            addSiblings() //5 add siblings: uneven in middle, even one right of middle.
                          //If #sib uneven: uneven one left of middle.
            
            setDrawingPoints(rowX: -2, colY: placementCounter) //6 Go to parent row and middle of patient siblings
            
            addParents() //7 draw parents with above connectors
            
            patientParentConnectors() //8 draw patient parent connectors
            
            placementConnectorFatherGrandparents() // determine middle of father sibblings
            
            setDrawingPointsRelative(rowX: 0, colY: placementCounter) // set to middle of sibblings
            
            addFatherSiblings() //10 draw sibblings
            
            setDrawingPoints(rowX: -4, colY: placementCounter + 1) //11 set to middle of sibblings on grandparent row
            
//          fatherGrandparentConnectors() // draw grandparent connectors
            
            setDrawingPoints(rowX: 0, colY: 0) // reset to patient position
            
            placementPatientParentConnector() //determine middle of patient sibblings
            
            setDrawingPointsRelative(rowX: -2, colY: placementCounter - 1) // got to patient mother position...
            
            placementConnectorMotherGrandparents()
            
            setDrawingPointsRelative(rowX: 0, colY: placementCounter)
            
            addMotherSiblings() //12
            
            setDrawingPointsRelative(rowX: -2, colY: 0)
            
//          motherGrandparentConnectors()
            
            setDrawingPoints(rowX: 2, colY: -2) //13
            
            addChilderen() //14
            
            childerenPatientConnector() //15
        }
        
    }
    
}



