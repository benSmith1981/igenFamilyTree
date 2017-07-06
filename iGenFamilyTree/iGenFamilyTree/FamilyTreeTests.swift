////
////  FamilyTreeTests.swift
////  iGenFamilyTree
////
////  Created by ben on 03/07/2017.
////  Copyright © 2017 ben. All rights reserved.
////
//
//import Foundation
//
//class FamilyTreeTests {
//    var familyTreeGen: FamilyTreeGenerator
//    var humans: [ID: Human] = [:]
//    var patient: Patient = Patient(id: "")
//
//    init(familyTree: FamilyTreeGenerator) {
//        self.familyTreeGen = familyTree
//        setupTestFamily()
//        fillFamilyTreeFor()
//

import Foundation

class FamilyTreeTests {
    var patient: Patient = Patient(id: "")
    var familyTree: [ID: Human] = [:]
    
    var newUUID = ""
    
    let brothers = 2
    let sisters = 0
    let sons = 1
    let daughters = 1
    let brothersOfMother = 3
    let sistersOfMother = 1
    let brothersOfFather = 0
    let sistersOfFather = 1
    
    func setupEmptyFamily() {
        
        // create empty Humans
        
        patient.id = NSUUID().uuidString
        familyTree[patient.id!] = Human(name: "Patient", id: patient.id!, patientID: patient.id!, gender: "unknown")
        newUUID = NSUUID().uuidString
        patient.myParentsIDs.append(newUUID)
        familyTree[newUUID] = Human(name: "Father", id: newUUID, patientID: patient.id!, gender: "male")
        newUUID = NSUUID().uuidString
        patient.myParentsIDs.append(newUUID)
        familyTree[newUUID] = Human(name: "Mother", id: newUUID, patientID: patient.id!, gender: "female")
        if sons + daughters > 0  { // add a spouse if patient has children
            newUUID = NSUUID().uuidString
            patient.mySpousesIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Spouse", id: newUUID, patientID: patient.id!, gender: "unknown")
        }
        
        for i in 1 ... brothers {
            newUUID = NSUUID().uuidString
            patient.mySiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Brother \(i)", id: newUUID, patientID: patient.id!, gender: "male")
        }
        for i in 1 ... sisters {
            newUUID = NSUUID().uuidString
            patient.mySiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Sister \(i)", id: newUUID, patientID: patient.id!, gender: "female")
        }
        for i in 1 ... sons {
            newUUID = NSUUID().uuidString
            patient.myChildrenIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Son \(i)", id: newUUID, patientID: patient.id!, gender: "male")
        }
        for i in 1 ... daughters {
            newUUID = NSUUID().uuidString
            patient.myChildrenIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Daughter \(i)", id: newUUID, patientID: patient.id!, gender: "female")
        }
        for i in 1 ... brothersOfMother {
            newUUID = NSUUID().uuidString
            patient.motherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "brotherOfMother \(i)", id: newUUID, patientID: patient.id!, gender: "male")
        }
        for i in 1 ... sistersOfMother {
            newUUID = NSUUID().uuidString
            patient.motherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "sisterOfMother \(i)", id: newUUID, patientID: patient.id!, gender: "female")
        }
        for i in 1 ... brothersOfFather {
            newUUID = NSUUID().uuidString
            patient.fatherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "brotherOfFather \(i)", id: newUUID, patientID: patient.id!, gender: "male")
        }
        for i in 1 ... sistersOfFather {
            newUUID = NSUUID().uuidString
            patient.fatherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "sisterOfFather \(i)", id: newUUID, patientID: patient.id!, gender: "female")
        }
        
        printResults(for: patient)
        
        // create all relationships for every human
        
        for id in familyTree.keys {
            if id == patient.id! { // this is the patient
                familyTree[id]?.spouses = patient.mySpousesIDs
                familyTree[id]?.parents = patient.myParentsIDs
                familyTree[id]?.children = patient.myChildrenIDs
                familyTree[id]?.siblings = patient.mySiblingsIDs
            } else if patient.mySpousesIDs.contains(id) { // this is a spouse of the patient
                familyTree[id]?.spouses.append(patient.id!) // add patient as spouse
                familyTree[id]?.children = patient.myChildrenIDs // add children of the patient            
            } else if patient.myParentsIDs.contains(id) { // this is a parent of the patient
                for arrayID in patient.myParentsIDs {
                    if id != arrayID {
                        familyTree[id]?.spouses.append(arrayID) // add other parent as spouse
                    }
                }
                familyTree[id]?.children.append(patient.id!) // add patient as child
                if familyTree[id]?.gender == "male" {
                    familyTree[id]?.siblings = patient.fatherSiblingsIDs // add siblings of my father
                } else {
                    familyTree[id]?.siblings = patient.motherSiblingsIDs // add siblings of my mother
                }
            } else if patient.myChildrenIDs.contains(id) { // this is a child of the patient
                familyTree[id]?.parents.append(patient.id!) // add patient as parent
                if familyTree[id]?.gender == "male" {
                    familyTree[id]?.siblings = patient.fatherSiblingsIDs // add siblings of my father
                } else {
                    familyTree[id]?.siblings = patient.motherSiblingsIDs // add siblings of my mother
                }
            } else if patient.mySiblingsIDs.contains(id) { // this is a sibling of the patient
                familyTree[id]?.parents = patient.myParentsIDs // add parents of the patient as parents of my sibling
                familyTree[id]?.siblings.append(patient.id!) // add patient as sibling
                for arrayID in patient.mySiblingsIDs {
                    if id != arrayID {
                        familyTree[id]?.siblings.append(arrayID) // add other siblings as sibling
                    }
                }
            } else if patient.fatherSiblingsIDs.contains(id) { // this is a sibling of the father of the patient
                for arrayID in patient.fatherSiblingsIDs {
                    if id != arrayID {
                        familyTree[id]?.siblings.append(arrayID) // add other siblings as sibling
                    }
                }
                for arrayID in patient.myParentsIDs {
                    if familyTree[arrayID]?.gender == "male" {
                        familyTree[id]?.siblings.append(arrayID) // add my father as sibling
                    }
                }
            } else if patient.motherSiblingsIDs.contains(id) { // this is a sibling of the mother of the patient
                for arrayID in patient.motherSiblingsIDs {
                    if id != arrayID {
                        familyTree[id]?.siblings.append(arrayID) // add other siblings as sibling
                    }
                }
                for arrayID in patient.myParentsIDs {
                    if familyTree[arrayID]?.gender == "female" {
                        familyTree[id]?.siblings.append(arrayID) // add my mother as sibling
                    }
                }
            }
        }
        
        printCurrent(familyTree: familyTree)
        
    }
    
    //        familyTree[patientUUID]?.parents.append(newUUID) // add parentID to patient
    //        familyTree[newUUID]?.children.append(patientUUID) // add patientID to parent
    //
    //        familyTree[patientUUID]?.siblings.append(newUUID) // add siblingID to patient
    //
    //        familyTree[patientUUID]?.siblings.append(newUUID) // add childrenID to patient
    //
    //        familyTree[patient.id]?.siblings.append(newUUID) // add siblingID to patient
    //        familyTree[patientUUID]?.siblings.append(newUUID) // add childrenID to patient
    //
    //
    //         self.familyTree["Mien"] = Human(name: "Mien", gender: "F")
    //
    //        addSpouseFor("Ton", spouse: "Dorine")
    //        addChildFor("Ton", child: "Tim")
    //        addChildFor("Ton", child: "Iris")
    //        addParentFor("Ton", parent: "Frans")
    //        addParentFor("Ton", parent: "Dora")
    //        addSiblingFor("Ton", sibling: "Rianne")
    //        addSiblingFor("Ton", sibling: "Annemieke")
    //
    //        addSpouseFor("Dorine", spouse: "Ton")
    //        addChildFor("Dorine", child: "Tim")
    //        addChildFor("Dorine", child: "Iris")
    //
    //        addParentFor("Tim", parent: "Ton")
    //        addSiblingFor("Tim", sibling: "Iris")
    //
    //        addParentFor("Iris", parent: "Ton")
    //        addSiblingFor("Iris", sibling: "Tim")
    //
    //    }
    
    func printCurrent(familyTree: [ID: Human]) {
        for id in familyTree.keys {
            print("name:", familyTree[id]!.name)
            for spouseID in familyTree[id]!.spouses {
                print("spouse:", familyTree[spouseID]!.name)
            }
            for parentID in familyTree[id]!.parents {
                print("parent:", familyTree[parentID]!.name)
            }
            for childID in familyTree[id]!.children {
                print("child:", familyTree[childID]!.name)
            }
            for siblingID in familyTree[id]!.siblings {
                print("sibling:", familyTree[siblingID]!.name)
            }
            print("")
        }
    }
    
    func printResults(for patient: Patient) {
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
        
        
        //        for i in patient.row - 2 ... patient.row + 2 {
        //            for j in 0 ... 19 {
        //                print(familyTree.model?.cell?[i][j], " ", terminator: "")
        //            }
        //            print("")
        //        }
    }
    
    
    //    func addSpouseFor(_ id: ID, spouse: ID) {
    //        familyTreeGen.familyTree[id]!.spouses.append(spouse)
    //    }
    //
    //    func addParentFor(_ id: ID, parent: ID) {
    //        familyTreeGen.familyTree[id]!.parents.append(parent)
    //    }
    //
    //    func addChildFor(_ id: ID, child: ID) {
    //        familyTreeGen.familyTree[id]!.children.append(child)
    //    }
    //
    //    func addSiblingFor(_ id: ID, sibling: ID) {
    //        familyTreeGen.familyTree[id]!.siblings.append(sibling)
    //    }
    
    //    func fillFamilyTreeFor() {
    //        for (id , human) in familyTree {
    //            print(id)
    //
    //            for parentID in human.parents {
    //                addParentFor(id, parent: parentID)
    //            }
    //
    //            for spouseID in human.spouses {
    //                addSpouseFor(id, spouse: spouseID)
    //            }
    //
    //            for childID in human.children {
    //                addChildFor(id, child: childID)
    //            }
    //
    //            for siblingID in human.siblings {
    //                addSiblingFor(id, sibling: siblingID)
    //            }
    //        }
    //
    //    }
}
