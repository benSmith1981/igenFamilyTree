//
//  iGenCollectionViewController.swift
//  iGenFamilyTree
//
//  Created by Achid Farooq on 28-06-17.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

let reuseIdentifier = "collectionViewCell"
    var familyItems: [Humans] = []


class CustomCollectionViewController: UICollectionViewController {
        
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
        var searchesDict: Dictionary<String,[Humans]> = notification.userInfo as! Dictionary<String,[Humans]>
        familyItems = searchesDict["iGenData"]!
        print("notify observer \(familyItems)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 10
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        // Configure the cell
        cell.label.text = "Sec \(indexPath.section)/Item \(indexPath.item)"
//        cell.label.text = "Sec \(indexPath.section)/Item \(indexPath.item)"


        return cell
    }

}
