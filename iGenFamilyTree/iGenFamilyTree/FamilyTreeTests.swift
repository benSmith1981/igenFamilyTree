//
//  FamilyTreeTests.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

class FamilyTreeTests {
    var familyTreeGen: FamilyTreeGenerator
    var humans: [ID: Human] = [:]
    var patient: Patient = Patient(id: "")
    
    init(familyTree: FamilyTreeGenerator) {
        self.familyTreeGen = familyTree
        setupTestFamily()
        fillFamilyTreeFor()

        familyTreeGen.familyTree = self.humans
        familyTreeGen.makeTreeFor("id1")
        familyTreeGen.makeModelFromTree()
        
        printCurrent(humans: familyTreeGen.familyTree, with: "id1")
        printResults(for: familyTree.patient)
    }
    
    func setupTestFamily() -> [ID: Human]{
        self.humans["Ton"] = Human(name: "Ton", gender: "M")
        self.humans["Dorine"] = Human(name: "Dorine", gender: "F")
        self.humans["Tim"] = Human(name: "Tim", gender: "M")
        self.humans["Iris"] = Human(name: "Iris", gender: "F")
        self.humans["Frans"] = Human(name: "Frans", gender: "M")
        self.humans["Dora"] = Human(name: "Dora", gender: "F")
        self.humans["Rianne"] = Human(name: "Rianne", gender: "F")
        self.humans["Annemieke"] = Human(name: "Annemieke", gender: "F")
        self.humans["Ad"] = Human(name: "Ad", gender: "M")
        self.humans["Willy"] = Human(name: "Willy", gender: "M")
        self.humans["Tiny"] = Human(name: "Tiny", gender: "M")
        self.humans["Toos"] = Human(name: "Toos", gender: "F")
        self.humans["Mien"] = Human(name: "Mien", gender: "F")
        
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
        
        return humans
    }
    
    func printCurrent(humans: [ID: Human] , with id: ID) {
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
        
        
        for i in patient.row - 2 ... patient.row + 2 {
            for j in 0 ... 19 {
                print(familyTreeGen.model?.cell?[i][j], " ", terminator: "")
            }
            print("")
        }
    }
    
    
    func addSpouseFor(_ id: ID, spouse: ID) {
        familyTreeGen.familyTree[id]!.spouses.append(spouse)
    }
    
    func addParentFor(_ id: ID, parent: ID) {
        familyTreeGen.familyTree[id]!.parents.append(parent)
    }
    
    func addChildFor(_ id: ID, child: ID) {
        familyTreeGen.familyTree[id]!.children.append(child)
    }
    
    func addSiblingFor(_ id: ID, sibling: ID) {
        familyTreeGen.familyTree[id]!.siblings.append(sibling)
    }
    
    func fillFamilyTreeFor() {
        for (id , human) in familyTreeGen.familyTree {
//            print(patientID)
//            print(human.id)
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
