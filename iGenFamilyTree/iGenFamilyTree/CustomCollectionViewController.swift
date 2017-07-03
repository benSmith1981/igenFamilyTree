//
//  CustomCollectionViewController.swift
//  MultiDirectionCollectionView
//
//  Created by Kyle Andrews on 3/21/15.
//  Copyright (c) 2015 Credera. All rights reserved.
//

import UIKit

let reuseIdentifier = "customCell"

class CustomCollectionViewController: UICollectionViewController {
    
    var familyTreeGenerator: FamilyTreeGenerator?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        iGenDataService.parseiGenData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CustomCollectionViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: "iGenData" ),
                                               object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Do any additional setup after loading the view.
    }
    func notifyObservers(notification: NSNotification) {
        //        var searchesDict: Dictionary<String,[Humans]> = notification.userInfo as! Dictionary<String,[Humans]>
        let familyDict: [ID: Human] = notification.userInfo as! [ID : Human]
//        let human = familyDict["id1"] as! Human
        
        //we assume you are the patient, maybe this comes from whoever logged in? So changed ID1 accordingly
        
//        let tests = FamilyTreeTests.init()
        
        familyTreeGenerator = FamilyTreeGenerator.init(familyTree: familyDict)
        familyTreeGenerator?.fillFamilyTreeFor()
        familyTreeGenerator?.makeTreeFor("id1")
        familyTreeGenerator?.makeModelFromTree()

        self.collectionView?.reloadData()
        

        print("notify observer \(familyDict)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        // Configure the cell
        let model = familyTreeGenerator?.model?.cell?[indexPath.section][indexPath.item]
//        let currentHuman = humans[model]
//        print(currentHuman?.name)
        cell.label.text = model
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    
    
}
