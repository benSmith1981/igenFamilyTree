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
        
        //collectionView?.minimumZoomScale = 0.25
        //collectionView?.maximumZoomScale = 4.0
        
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
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellIdentifiers.iGenCellID.rawValue, for: indexPath) as! iGenCell
        
        // Configure the cell
        guard let cellContent = familyTreeGenerator?.model?.cell?[indexPath.section][indexPath.item] else {
            cell.bgImg.image = UIImage()
            return cell
        }
        
        cell.bgImg.image = cellContent.switchBG()
        if let currentHuman = familyTreeGenerator?.familyTree[cellContent.getID()] {
            processHuman(currentHuman, cell: &cell)
            cell.genderImg.image = cellContent.showGender()
            if let currentDisease = familyTreeGenerator?.diseases[cellContent.getID()] {
                processDisease(currentDisease, cell: &cell)
            }
        }
        return cell
    }
   
    private func processHuman(_ currentHuman: Human, cell: inout iGenCell) {
        print("currentHuman:", currentHuman.name)
        cell.patientName.text = currentHuman.name
        cell.patientAge.text = currentHuman.dob
        cell.diseaseImg1Color.backgroundColor = UIColor.black
    }
    
    private func processDisease(_ currentDisease: Disease, cell: inout iGenCell) {
        print("currentDisease:", currentDisease.diseaseList)
        switch currentDisease.diseaseList.count {
        case 1:
            cell.diseaseImg1Color.backgroundColor = UIColor.diseaseColor(1)
            cell.diseaseLabel1.backgroundColor = UIColor.diseaseColor(1)
            cell.diseaseLabel1.text = String(currentDisease.diseaseList[0])
        case 2:
            cell.diseaseImg2ColorsTop.backgroundColor = UIColor.diseaseColor(1)
            cell.diseaseImg2ColorsBottom.backgroundColor = UIColor.diseaseColor(2)
            cell.diseaseLabel1.backgroundColor = UIColor.diseaseColor(1)
            cell.diseaseLabel2.backgroundColor = UIColor.diseaseColor(2)
            cell.diseaseLabel1.text = String(currentDisease.diseaseList[0])
            cell.diseaseLabel2.text = String(currentDisease.diseaseList[1])
        case 3:
            cell.diseaseImg3ColorsTop.backgroundColor = UIColor.diseaseColor(1)
            cell.diseaseImg3ColorsMiddle.backgroundColor = UIColor.diseaseColor(2)
            cell.diseaseImg2ColorsBottom.backgroundColor = UIColor.diseaseColor(3)
            cell.diseaseLabel1.backgroundColor = UIColor.diseaseColor(1)
            cell.diseaseLabel2.backgroundColor = UIColor.diseaseColor(2)
            cell.diseaseLabel3.backgroundColor = UIColor.diseaseColor(3)
            cell.diseaseLabel1.text = String(currentDisease.diseaseList[0])
            cell.diseaseLabel2.text = String(currentDisease.diseaseList[1])
            cell.diseaseLabel3.text = String(currentDisease.diseaseList[2])
        default:
            break
        }
    }
    
}
