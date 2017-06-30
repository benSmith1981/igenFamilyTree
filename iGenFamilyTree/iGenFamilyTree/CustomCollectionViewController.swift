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
    
    var familyItems: [Humans] = []
    
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
        //        familyItems = searchesDict["iGenData"]!
        let familyDict: [String: Humans] = notification.userInfo as! [String : Humans]
//        let human = familyDict["id1"] as! Human
        let key = familyDict
        fillFamilyTreeFor("ID1")

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
        cell.label.text = Model.cell[indexPath.section][indexPath.item]
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    
    
}
