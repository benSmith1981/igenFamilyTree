//
//  FamilyTreeTests.swift
//  iGenFamilyTree
//
//  Created by ben on 03/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation

class FamilyTreeTests {
    var humans: [ID: Human] = [:]
    var patient: Patient
    var familyTree: FamilyTree
    
    init(familyTree: FamilyTree, humans: [ID: Human], patient: Patient) {
        self.familyTree = familyTree
        self.humans = humans
        self.patient = patient
    }
    
    func setupTestFamily() {
        humans["Ton"] = Human(name: "Ton", gender: "M")
        humans["Dorine"] = Human(name: "Dorine", gender: "F")
        humans["Tim"] = Human(name: "Tim", gender: "M")
        humans["Iris"] = Human(name: "Iris", gender: "F")
        humans["Frans"] = Human(name: "Frans", gender: "M")
        humans["Dora"] = Human(name: "Dora", gender: "F")
        humans["Rianne"] = Human(name: "Rianne", gender: "F")
        humans["Annemieke"] = Human(name: "Annemieke", gender: "F")
        humans["Ad"] = Human(name: "Ad", gender: "M")
        humans["Willy"] = Human(name: "Willy", gender: "M")
        humans["Tiny"] = Human(name: "Tiny", gender: "M")
        humans["Toos"] = Human(name: "Toos", gender: "F")
        humans["Mien"] = Human(name: "Mien", gender: "F")
        
        familyTree.addSpouseFor("Ton", spouse: "Dorine")
        familyTree.addChildFor("Ton", child: "Tim")
        familyTree.addChildFor("Ton", child: "Iris")
        familyTree.addParentFor("Ton", parent: "Frans")
        familyTree.addParentFor("Ton", parent: "Dora")
        familyTree.addSiblingFor("Ton", sibling: "Rianne")
        familyTree.addSiblingFor("Ton", sibling: "Annemieke")
        
        familyTree.addSpouseFor("Dorine", spouse: "Ton")
        familyTree.addChildFor("Dorine", child: "Tim")
        familyTree.addChildFor("Dorine", child: "Iris")
        
        familyTree.addParentFor("Tim", parent: "Ton")
        familyTree.addSiblingFor("Tim", sibling: "Iris")
        
        familyTree.addParentFor("Iris", parent: "Ton")
        familyTree.addSiblingFor("Iris", sibling: "Tim")
        
        familyTree.addSpouseFor("Frans", spouse: "Dora")
        familyTree.addChildFor("Frans", child: "Ton")
        familyTree.addChildFor("Frans", child: "Rianne")
        familyTree.addChildFor("Frans", child: "Annemieke")
        familyTree.addSiblingFor("Frans", sibling: "Ad")
        familyTree.addSiblingFor("Frans", sibling: "Willy")
        familyTree.addSiblingFor("Frans", sibling: "Tiny")
        familyTree.addSiblingFor("Frans", sibling: "Toos")
        familyTree.addSiblingFor("Frans", sibling: "Mien")
        
        familyTree.addSiblingFor("Ad", sibling: "Frans")
        familyTree.addSiblingFor("Ad", sibling: "Willy")
        familyTree.addSiblingFor("Ad", sibling: "Tiny")
        familyTree.addSiblingFor("Ad", sibling: "Toos")
        familyTree.addSiblingFor("Ad", sibling: "Mien")
        
        familyTree.addSiblingFor("Willy", sibling: "Ad")
        familyTree.addSiblingFor("Willy", sibling: "Frans")
        familyTree.addSiblingFor("Willy", sibling: "Tiny")
        familyTree.addSiblingFor("Willy", sibling: "Toos")
        familyTree.addSiblingFor("Willy", sibling: "Mien")
        
        familyTree.addSiblingFor("Tiny", sibling: "Ad")
        familyTree.addSiblingFor("Tiny", sibling: "Willy")
        familyTree.addSiblingFor("Tiny", sibling: "Frans")
        familyTree.addSiblingFor("Tiny", sibling: "Toos")
        familyTree.addSiblingFor("Tiny", sibling: "Mien")
        
        familyTree.addSiblingFor("Toos", sibling: "Ad")
        familyTree.addSiblingFor("Toos", sibling: "Willy")
        familyTree.addSiblingFor("Toos", sibling: "Tiny")
        familyTree.addSiblingFor("Toos", sibling: "Frans")
        familyTree.addSiblingFor("Toos", sibling: "Mien")
        
        familyTree.addSiblingFor("Mien", sibling: "Ad")
        familyTree.addSiblingFor("Mien", sibling: "Willy")
        familyTree.addSiblingFor("Mien", sibling: "Tiny")
        familyTree.addSiblingFor("Mien", sibling: "Toos")
        familyTree.addSiblingFor("Mien", sibling: "Frans")
        
        familyTree.addSpouseFor("Dora", spouse: "Frans")
        familyTree.addChildFor("Dora", child: "Ton")
        familyTree.addChildFor("Dora", child: "Rianne")
        familyTree.addChildFor("Dora", child: "Annemieke")
        
        familyTree.addParentFor("Rianne", parent: "Frans")
        familyTree.addParentFor("Rianne", parent: "Dora")
        familyTree.addSiblingFor("Rianne", sibling: "Ton")
        familyTree.addSiblingFor("Rianne", sibling: "Annemieke")
        
        familyTree.addParentFor("Annemieke", parent: "Frans")
        familyTree.addParentFor("Annemieke", parent: "Dora")
        familyTree.addSiblingFor("Annemieke", sibling: "Ton")
        familyTree.addSiblingFor("Annemieke", sibling: "Rianne")
    }
    
    func printHuman(_ id: ID) {
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
    
    func printResults() {
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
                print(Model.cell[i][j], " ", terminator: "")
            }
            print("")
        }
    }
    
}
