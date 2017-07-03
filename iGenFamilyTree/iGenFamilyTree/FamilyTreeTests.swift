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
    
    init() {
        self.familyTreeGen = familyTree
        self.humans = setupTestFamily()
   
        familyTreeGen.familyTree = self.humans
        familyTreeGen.fillFamilyTreeFor()
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
        
        familyTreeGen.addSpouseFor("Ton", spouse: "Dorine")
        familyTreeGen.addChildFor("Ton", child: "Tim")
        familyTreeGen.addChildFor("Ton", child: "Iris")
        familyTreeGen.addParentFor("Ton", parent: "Frans")
        familyTreeGen.addParentFor("Ton", parent: "Dora")
        familyTreeGen.addSiblingFor("Ton", sibling: "Rianne")
        familyTreeGen.addSiblingFor("Ton", sibling: "Annemieke")
        
        familyTreeGen.addSpouseFor("Dorine", spouse: "Ton")
        familyTreeGen.addChildFor("Dorine", child: "Tim")
        familyTreeGen.addChildFor("Dorine", child: "Iris")
        
        familyTreeGen.addParentFor("Tim", parent: "Ton")
        familyTreeGen.addSiblingFor("Tim", sibling: "Iris")
        
        familyTreeGen.addParentFor("Iris", parent: "Ton")
        familyTreeGen.addSiblingFor("Iris", sibling: "Tim")
        
        familyTreeGen.addSpouseFor("Frans", spouse: "Dora")
        familyTreeGen.addChildFor("Frans", child: "Ton")
        familyTreeGen.addChildFor("Frans", child: "Rianne")
        familyTreeGen.addChildFor("Frans", child: "Annemieke")
        familyTreeGen.addSiblingFor("Frans", sibling: "Ad")
        familyTreeGen.addSiblingFor("Frans", sibling: "Willy")
        familyTreeGen.addSiblingFor("Frans", sibling: "Tiny")
        familyTreeGen.addSiblingFor("Frans", sibling: "Toos")
        familyTreeGen.addSiblingFor("Frans", sibling: "Mien")
        
        familyTreeGen.addSiblingFor("Ad", sibling: "Frans")
        familyTreeGen.addSiblingFor("Ad", sibling: "Willy")
        familyTreeGen.addSiblingFor("Ad", sibling: "Tiny")
        familyTreeGen.addSiblingFor("Ad", sibling: "Toos")
        familyTreeGen.addSiblingFor("Ad", sibling: "Mien")
        
        familyTreeGen.addSiblingFor("Willy", sibling: "Ad")
        familyTreeGen.addSiblingFor("Willy", sibling: "Frans")
        familyTreeGen.addSiblingFor("Willy", sibling: "Tiny")
        familyTreeGen.addSiblingFor("Willy", sibling: "Toos")
        familyTreeGen.addSiblingFor("Willy", sibling: "Mien")
        
        familyTreeGen.addSiblingFor("Tiny", sibling: "Ad")
        familyTreeGen.addSiblingFor("Tiny", sibling: "Willy")
        familyTreeGen.addSiblingFor("Tiny", sibling: "Frans")
        familyTreeGen.addSiblingFor("Tiny", sibling: "Toos")
        familyTreeGen.addSiblingFor("Tiny", sibling: "Mien")
        
        familyTreeGen.addSiblingFor("Toos", sibling: "Ad")
        familyTreeGen.addSiblingFor("Toos", sibling: "Willy")
        familyTreeGen.addSiblingFor("Toos", sibling: "Tiny")
        familyTreeGen.addSiblingFor("Toos", sibling: "Frans")
        familyTreeGen.addSiblingFor("Toos", sibling: "Mien")
        
        familyTreeGen.addSiblingFor("Mien", sibling: "Ad")
        familyTreeGen.addSiblingFor("Mien", sibling: "Willy")
        familyTreeGen.addSiblingFor("Mien", sibling: "Tiny")
        familyTreeGen.addSiblingFor("Mien", sibling: "Toos")
        familyTreeGen.addSiblingFor("Mien", sibling: "Frans")
        
        familyTreeGen.addSpouseFor("Dora", spouse: "Frans")
        familyTreeGen.addChildFor("Dora", child: "Ton")
        familyTreeGen.addChildFor("Dora", child: "Rianne")
        familyTreeGen.addChildFor("Dora", child: "Annemieke")
        
        familyTreeGen.addParentFor("Rianne", parent: "Frans")
        familyTreeGen.addParentFor("Rianne", parent: "Dora")
        familyTreeGen.addSiblingFor("Rianne", sibling: "Ton")
        familyTreeGen.addSiblingFor("Rianne", sibling: "Annemieke")
        
        familyTreeGen.addParentFor("Annemieke", parent: "Frans")
        familyTreeGen.addParentFor("Annemieke", parent: "Dora")
        familyTreeGen.addSiblingFor("Annemieke", sibling: "Ton")
        familyTreeGen.addSiblingFor("Annemieke", sibling: "Rianne")
        
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
    
}
