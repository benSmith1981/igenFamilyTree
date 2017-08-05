import Foundation

//  supporting function, just for testing

func fillFamilyTreeFor(_ id: ID) {
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
    humans["Test"] = Human(name: "Test", gender: "F")
    
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
    addSiblingFor("Dora", sibling: "Test")

    addSiblingFor("Test", sibling: "Dora")
    
    addParentFor("Rianne", parent: "Frans")
    addParentFor("Rianne", parent: "Dora")
    addSiblingFor("Rianne", sibling: "Ton")
    addSiblingFor("Rianne", sibling: "Annemieke")
    
    addParentFor("Annemieke", parent: "Frans")
    addParentFor("Annemieke", parent: "Dora")
    addSiblingFor("Annemieke", sibling: "Ton")
    addSiblingFor("Annemieke", sibling: "Rianne")
}
