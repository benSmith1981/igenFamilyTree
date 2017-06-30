//
//  Family Tree.swift
//  iGenFamilyTree
//
//  Created by Ton on 2017-06-30.
//  Copyright © 2017. All rights reserved.
//

import Foundation

typealias ID = String

//  Human is a very generic structure of all relationships a human can have in this family
//  the processed boolean variable is used in function traverseTreeFor to prevent endless looping

struct Human {
    var name: String
    var gender: String
    var processed: Bool = false
    var spouses: [ID] = []
    var parents: [ID] = []
    var children: [ID] = []
    var siblings: [ID] = []
    
    init(name: String, gender: String) {
        self.name = name
        self.gender = gender
    }
}

var humans: [ID: Human] = [:]

//  Patient for whom we have to maintain a family tree
//  row and col are starting points for the modelling of the family tree
//  we build this structure from the humans array, which contains all humans in this family

struct Patient {
    static var id: ID = ""
    static var row = 7
    static var col = 7
    static var mySpousesIDs: [ID] = []
    static var myParentsIDs: [ID] = []
    static var myChildrenIDs: [ID] = []
    static var mySiblingsIDs: [ID] = []
    static var fatherSiblingsIDs: [ID] = []
    static var motherSiblingsIDs: [ID] = []
}

//  Model is a 2D matrix for building the family tree and connecting the nodes
//  we build this from the Patient structure

struct Model {
    static var minLevel = 1
    static var maxLevel = 1
    static var cell: [[String]] = Array(repeating: Array(repeating: "", count: 15), count: 15)
}

//  functions for populating the Patient structure by calling function traverseTreeFor,
//  which is then again called recursively for every human
//  it also calculates the minimum and maximum levels traversed
//  for processing siblings we need to test for siblings of the Patient or siblings of the father or mother of the Patient

func makeTreeFor(_ id: ID) {
    let level = 1
    Patient.id = id
    print("Family tree for", humans[id]!.name, "is on level", level)
    traverseTreeFor(id, level)
    print("minLevel=", Model.minLevel)
    print("maxLevel=", Model.maxLevel)
    print("")
}

private func traverseTreeFor(_ id: ID, _ level: Int) {
    if humans[id]!.processed == false {
        humans[id]!.processed = true
        Model.maxLevel = max(Model.maxLevel, level)
        Model.minLevel = min(Model.minLevel, level)
        for spouseID in humans[id]!.spouses {
            print("spouse of", humans[id]!.name, "is", humans[spouseID]!.name, "on level", level)
            if id == Patient.id {
                Patient.mySpousesIDs.append(spouseID)
            }
            traverseTreeFor(spouseID, level)
        }
        for parentID in humans[id]!.parents {
            print("parent of", humans[id]!.name, "is", humans[parentID]!.name, "on level", level - 1)
            if id == Patient.id {
                Patient.myParentsIDs.append(parentID)
            }
            traverseTreeFor(parentID, level - 1)
        }
        for childID in humans[id]!.children {
            print("child of", humans[id]!.name, "is", humans[childID]!.name, "on level", level + 1)
            if id == Patient.id {
                Patient.myChildrenIDs.append(childID)
            }
            traverseTreeFor(childID, level + 1)
        }
        for siblingID in humans[id]!.siblings {
            print("sibling of", humans[id]!.name, "is", humans[siblingID]!.name, "on level", level)
            if id == Patient.id {
                Patient.mySiblingsIDs.append(siblingID)
            } else if humans[Patient.id]!.parents.contains(id) {
                if humans[id]!.gender == "M" {
                    Patient.fatherSiblingsIDs.append(siblingID)
                } else {
                    Patient.motherSiblingsIDs.append(siblingID)
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
    var row = Patient.row
    var col = Patient.col
    Model.cell[row][col] = Patient.id
    col = Patient.col - 1
    for id in Patient.mySpousesIDs {
        Model.cell[row][col] = "---,---"
        col -= 1
        Model.cell[row][col] = id
    }
    row = Patient.row
    col = Patient.col
    for id in Patient.mySiblingsIDs {
        col += 1
        Model.cell[row][col] = id
        Model.cell[row - 1][Patient.col] = "|--"
        if id == Patient.mySiblingsIDs.last {
            Model.cell[row - 1][col] = "--,"
        } else {
            Model.cell[row - 1][col] = "-------"
        }
    }
    row = Patient.row - 2
    col = Patient.col
    for id in Patient.myParentsIDs {
        if humans[id]!.gender == "M" {
            Model.cell[row][col + 1] = id
        } else {
            Model.cell[row][col - 1] = id
        }
    }
    if Patient.myParentsIDs.count == 2 {
        Model.cell[row][col] = "---,---"
    }
    row = Patient.row - 2
    col = Patient.col + 1
    for id in Patient.fatherSiblingsIDs {
        col += 1
        Model.cell[row][col] = id
        Model.cell[row - 1][Patient.col + 1] = ",--"
        if id == Patient.fatherSiblingsIDs.last {
            Model.cell[row - 1][col] = "--,"
        } else {
            Model.cell[row - 1][col] = "-------"
        }
    }
    row = Patient.row - 2
    col = Patient.col - 1
    for id in Patient.motherSiblingsIDs {
        col -= 1
        Model.cell[row][col] = id
        Model.cell[row - 1][Patient.col - 1] = "--,"
        if id == Patient.motherSiblingsIDs.last {
            Model.cell[row - 1][col] = ",--"
        } else {
            Model.cell[row - 1][col] = "-------"
        }
    }
    row = Patient.row + 2
    col = Patient.col - 2
    for id in Patient.myChildrenIDs {
        col += 1
        Model.cell[row][col] = id
        if id == Patient.myChildrenIDs.last {
            Model.cell[row - 1][col] = "--,"
        } else {
            Model.cell[row - 1][col] = "-------"
        }
    }
    if Patient.myChildrenIDs.count > 0 {
        Model.cell[row - 1][Patient.col - 1] = "|--"
    }
}

//  supporting functions for populating the humans array

func addSpouseFor(_ id: ID, spouse: ID) {
    humans[id]!.spouses.append(spouse)
}
func addParentFor(_ id: ID, parent: ID) {
    humans[id]!.parents.append(parent)
}
func addChildFor(_ id: ID, child: ID) {
    humans[id]!.children.append(child)
}
func addSiblingFor(_ id: ID, sibling: ID) {
    humans[id]!.siblings.append(sibling)
}

//  supporting function, just for debugging

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

//  supporting function, just for debugging

func printPatient() {
    for id in Patient.myParentsIDs {
        print("myParentsIDs", id)
    }
    for id in Patient.fatherSiblingsIDs {
        print("fatherSiblingsIDs", id)
    }
    for id in Patient.motherSiblingsIDs {
        print("motherSiblingsIDs", id)
    }
    for id in Patient.mySpousesIDs {
        print("mySpousesIDs", id)
    }
    for id in Patient.mySiblingsIDs {
        print("mySiblingsIDs", id)
    }
    for id in Patient.myChildrenIDs {
        print("myChildrenIDs", id)
    }
    print("")
}

//  supporting function, just for debugging

func printModel() {
    for i in Patient.row - 2 ... Patient.row + 2 {
        for j in 0 ... 14 {
            print(Model.cell[i][j], " ", terminator: "")
        }
        print("")
    }
    print("")
}
