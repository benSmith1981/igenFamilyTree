//
//  GenerateNewFamilyTree.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-06.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

extension FamilyTreeGenerator {

//class FamilyTreeTests {
//    var patient: Patient = Patient(id: "")
//    var familyTree: [ID: Human] = [:]
    
    
    func generateNewFamilyTree(with numberOf: Answers) {
        var newUUID: String
        var i: Int
        
        // create empty Humans
        
        patient.id = NSUUID().uuidString
        familyTree[patient.id!] = Human(name: "Patient", id: patient.id!, patientID: patient.id!, gender: "unknown")
        newUUID = NSUUID().uuidString
        patient.myParentsIDs.append(newUUID)
        familyTree[newUUID] = Human(name: "Father", id: newUUID, patientID: patient.id!, gender: "male")
        newUUID = NSUUID().uuidString
        patient.myParentsIDs.append(newUUID)
        familyTree[newUUID] = Human(name: "Mother", id: newUUID, patientID: patient.id!, gender: "female")
        if numberOf.sons + numberOf.daughters > 0  { // add a spouse if patient has children
            newUUID = NSUUID().uuidString
            patient.mySpousesIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Spouse", id: newUUID, patientID: patient.id!, gender: "unknown")
        }
        i = 1
        while i <= numberOf.brothers {
            newUUID = NSUUID().uuidString
            patient.mySiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Brother \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
        i = 1
        while i <= numberOf.sisters {
            newUUID = NSUUID().uuidString
            patient.mySiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Sister \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
        }
        i = 1
        while i <= numberOf.sons {
            newUUID = NSUUID().uuidString
            patient.myChildrenIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Son \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
        i = 1
        while i <= numberOf.daughters {
            newUUID = NSUUID().uuidString
            patient.myChildrenIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Daughter \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
        }
        i = 1
        while i <= numberOf.brothersOfMother {
            newUUID = NSUUID().uuidString
            patient.motherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "brotherOfMother \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
        i = 1
        while i <= numberOf.sistersOfMother {
            newUUID = NSUUID().uuidString
            patient.motherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "sisterOfMother \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
        }
        i = 1
        while i <= numberOf.brothersOfFather {
            newUUID = NSUUID().uuidString
            patient.fatherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "brotherOfFather \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
        i = 1
        while i <= numberOf.sistersOfFather {
            newUUID = NSUUID().uuidString
            patient.fatherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "sisterOfFather \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
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
}
