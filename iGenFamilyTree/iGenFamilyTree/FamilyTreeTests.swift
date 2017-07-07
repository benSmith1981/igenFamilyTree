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

