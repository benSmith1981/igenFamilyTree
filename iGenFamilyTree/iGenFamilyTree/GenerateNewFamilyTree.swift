//
//  GenerateNewFamilyTree.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-07-06.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

//Select gender for inputfield to create blank tree
enum genderType: String {
    case maleGender
    case femaleGender
    case unknown
    
    func selectGender() -> String {
        
        switch self {
        case .maleGender:
            return "male"
        case .femaleGender:
            return "female"
        case .unknown:
            return "unknown"
        }
    }
}

extension FamilyTreeGenerator {
    
    // generate a new family tree from the answers of the filled in form
    func generateNewFamilyTree(with numberOf: Answers) {
        createEmptyHumans(with: numberOf)
        printPatient(patient)
        createRelationships() // for all humans
        printFamilyTree(familyTree)
    }
    
    // first create an array of every empty Human in this family
    private func createEmptyHumans(with numberOf: Answers) {
        createEmptyPatient()
        createEmptyFather()
        createEmptyMother()
        
        if numberOf.sons + numberOf.daughters > 0  { // add a spouse only if patient has children
            createEmptySpouse()
        }
        createEmptyBrothers(numberOf.brothers)
        createEmptySisters(numberOf.sisters)
        createEmptySons(numberOf.sons)
        createEmptyDaughters(numberOf.daughters)
        createEmptyBrothersOfMother(numberOf.brothersOfMother)
        createEmptySistersOfMother(numberOf.sistersOfMother)
        createEmptyBrothersOfFather(numberOf.brothersOfFather)
        createEmptySistersOfFather(numberOf.sistersOfFather)
    }
    
    // generate a unique ID and create the patient
    private func createEmptyPatient() {
        patient.id = NSUUID().uuidString
        familyTree[patient.id!] = Human(name: "Patient", id: patient.id!, patientID: patient.id!, gender: "unknown")
    }
    
    // generate a unique ID, create the father and add him as a parent of the patient
    private func createEmptyFather() {
        let newUUID = NSUUID().uuidString
        patient.myParentsIDs.append(newUUID)
        familyTree[newUUID] = Human(name: "Father", id: newUUID, patientID: patient.id!, gender: "male")
    }
    
    // generate a unique ID, create the mother and add her as a parent of the patient
    private func createEmptyMother() {
        let newUUID = NSUUID().uuidString
        patient.myParentsIDs.append(newUUID)
        familyTree[newUUID] = Human(name: "Mother", id: newUUID, patientID: patient.id!, gender: "female")
    }
    
    // generate a unique ID, create the spouse and add him/her as a spouse of the patient
    private func createEmptySpouse() {
        let newUUID = NSUUID().uuidString
        patient.mySpousesIDs.append(newUUID)
        familyTree[newUUID] = Human(name: "Spouse", id: newUUID, patientID: patient.id!, gender: "unknown")
    }
    
    // for every brother, generate a unique ID, create the brother and add him as a sibling to the patient
    private func createEmptyBrothers(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.mySiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Brother \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
    }
    
    // for every sister, generate a unique ID, create the sister and add her as a sibling to the patient
    private func createEmptySisters(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.mySiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Sister \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
        }
    }
    
    // for every son, generate a unique ID, create the son and add him as a child to the patient
    private func createEmptySons(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.myChildrenIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Son \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
    }
    
    // for every daughter, generate a unique ID, create the daughter and add her as a child to the patient
    private func createEmptyDaughters(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.myChildrenIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "Daughter \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
        }
    }
    
    // for every brother of the mother of the patient, generate a unique ID, create him and add him as a sibling of the mother to the patient
    private func createEmptyBrothersOfMother(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.motherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "brotherOfMother \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
    }
    
    // for every sister of the mother of the patient, generate a unique ID, create her and add her as a sibling of the mother to the patient
    private func createEmptySistersOfMother(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.motherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "sisterOfMother \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
        }
    }
    
    // for every brother of the father of the patient, generate a unique ID, create him and add him as a sibling of the father to the patient
    private func createEmptyBrothersOfFather(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.fatherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "brotherOfFather \(i)", id: newUUID, patientID: patient.id!, gender: "male")
            i += 1
        }
    }
    
    // for every sister of the father of the patient, generate a unique ID, create her and add her as a sibling of the father to the patient
    private func createEmptySistersOfFather(_ number: Int) {
        var i = 1
        while i <= number {
            let newUUID = NSUUID().uuidString
            patient.fatherSiblingsIDs.append(newUUID)
            familyTree[newUUID] = Human(name: "sisterOfFather \(i)", id: newUUID, patientID: patient.id!, gender: "female")
            i += 1
        }
    }
    
    // for every Human in this family, now create all the relationships
    private func createRelationships() {
        for id in familyTree.keys {
            if id == patient.id! { 
                processPatient(id)
            } else if patient.mySpousesIDs.contains(id) {
                processPatientSpouse(id)
            } else if patient.myParentsIDs.contains(id) {
                processPatientParent(id)
            } else if patient.myChildrenIDs.contains(id) {
                processPatientChild(id)
            } else if patient.mySiblingsIDs.contains(id) {
                processPatientSibling(id)
            } else if patient.fatherSiblingsIDs.contains(id) {
                processFatherSibling(id)
            } else if patient.motherSiblingsIDs.contains(id) {
                processMotherSibling(id)
            }
        }
    }
    
    // process the patient
    private func processPatient(_ id: ID) {
        familyTree[id]?.spouses = patient.mySpousesIDs
        familyTree[id]?.parents = patient.myParentsIDs
        familyTree[id]?.children = patient.myChildrenIDs
        familyTree[id]?.siblings = patient.mySiblingsIDs
    }
    
    // process the spouse of the patient
    private func processPatientSpouse(_ id: ID) {
        familyTree[id]?.spouses.append(patient.id!) // add patient as spouse
        familyTree[id]?.children = patient.myChildrenIDs // add children of the patient
    }
    
    // process a parent of the patient
    private func processPatientParent(_ id: ID) {
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
    }
    
    // process a child of the patient
    private func processPatientChild(_ id: ID) {
        familyTree[id]?.parents.append(patient.id!) // add patient as parent
        if familyTree[id]?.gender == "male" {
            familyTree[id]?.siblings = patient.fatherSiblingsIDs // add siblings of my father
        } else {
            familyTree[id]?.siblings = patient.motherSiblingsIDs // add siblings of my mother
        }
    }
    
    // process a sibling of the patient
    private func processPatientSibling(_ id: ID) {
        familyTree[id]?.parents = patient.myParentsIDs // add parents of the patient as parents of my sibling
        familyTree[id]?.siblings.append(patient.id!) // add patient as sibling
        for arrayID in patient.mySiblingsIDs {
            if id != arrayID {
                familyTree[id]?.siblings.append(arrayID) // add other siblings as sibling
            }
        }
    }
    
    // process a sibling of the father of the patient
    private func processFatherSibling(_ id: ID) {
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
    }
    
    // process a sibling of the mother of the patient
    private func processMotherSibling(_ id: ID) {
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
    
    func printFamilyTree(_ familyTree: [ID: Human]) {
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
    
    func printPatient(_ patient: Patient) {
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
    }
}
