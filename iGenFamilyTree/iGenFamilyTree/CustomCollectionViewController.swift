//
//  CustomCollectionViewController.swift
//  MultiDirectionCollectionView
//
//  Created by Kyle Andrews on 3/21/15.
//  Copyright (c) 2015 Credera. All rights reserved.
//

import UIKit

class CustomCollectionViewController: UICollectionViewController {
    
    var familyTreeGenerator: FamilyTreeGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        iGenDataService.parseiGenData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CustomCollectionViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.iGenData.rawValue ),
                                               object: nil)
        
        //        iGenDataService.parseiGenDiseaseData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CustomCollectionViewController.notifyObserverDisease),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.iGenDiseaseData.rawValue ),
                                               object: nil)

        // segue from TableViewController
        // familyTreeGenerator will be nil if entered via iGenDataService
        // extract patientID from the first Human for function MakeTreeFor
        
        if let firstKey = familyTreeGenerator?.familyTree.first?.key,
            let patientID = familyTreeGenerator?.familyTree[firstKey]?.patientID {
            familyTreeGenerator?.makeTreeFor(patientID)
            familyTreeGenerator?.makeModelFromTree()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Do any additional setup after loading the view.
        
        
        configureCollectionView()
        
        
    }
    
    func configureCollectionView() {
        
        let defaultCell = UINib(nibName: "iGenCell", bundle:nil)
        self.collectionView?.register(defaultCell, forCellWithReuseIdentifier: CustomCellIdentifiers.iGenCellID.rawValue)
        
    }
    
    //  entered via iGenDataService
    
    func notifyObservers(notification: NSNotification) {
        let familyDict: [ID: Human] = notification.userInfo as! [ID : Human]
        familyTreeGenerator = FamilyTreeGenerator.init(familyTree: familyDict)
        
        // load the diseases
        familyTreeGenerator?.loadDiseases()
        
        // extract patientID from the first Human for function MakeTreeFor
        if let firstKey = familyTreeGenerator?.familyTree.first?.key,
            let patientID = familyTreeGenerator?.familyTree[firstKey]?.patientID {
            familyTreeGenerator?.makeTreeFor(patientID)
            familyTreeGenerator?.makeModelFromTree()
        } else {
            fatalError("Family tree not complete")
        }
        self.collectionView?.reloadData()
        print("notify observer humans\(familyDict)")
    }
    
    func notifyObserverDisease(notification: NSNotification) {
        let diseaseDict = notification.userInfo as! [ID : Disease]
        // there is always exactly 1 disease notified
        let diseaseKey = diseaseDict.first?.key
        let diseaseValue = diseaseDict.first?.value
        familyTreeGenerator?.diseases[diseaseKey!] = diseaseValue
        self.collectionView?.reloadData()
        print("notify observer disease \(diseaseDict)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.gridSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.gridSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellIdentifiers.iGenCellID.rawValue, for: indexPath) as! iGenCell
        
        // Configure the cell
        if let cellContent = familyTreeGenerator?.model?.cell?[indexPath.section][indexPath.item] {
            let currentHuman = familyTreeGenerator?.familyTree[cellContent.getID()]
            print(currentHuman?.name)
            cell.bgImg.image = cellContent.switchBG()
            cell.patientName.text = currentHuman?.name
            cell.patientAge.text = currentHuman?.dob
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    
    
}
