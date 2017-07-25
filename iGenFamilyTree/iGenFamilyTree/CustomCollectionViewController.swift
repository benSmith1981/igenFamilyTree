//
//  CustomCollectionViewController.swift
//  MultiDirectionCollectionView
//
//  Created by Kyle Andrews on 3/21/15.
//  Copyright (c) 2015 Credera. All rights reserved.
//

import UIKit
import DeviceKit
import Alamofire


class CustomCollectionViewController: UICollectionViewController {
    
    var familyTreeGenerator: FamilyTreeGenerator?
    var answers = Answers()
    var alertView: UIAlertController?
    var human = Human.self
    let transition = PopAnimator()
    var onceOnly = false
    let device = Device()
    var xPos = CGFloat(Double((Constants.gridSize / 2)) * (Constants.squareCellSize))
    var yPos = CGFloat(Double((Constants.gridSize / 2)) * (Constants.squareCellSize))
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    
    @IBAction func saveFamilyTree(_ sender: Any) {
        print("Back Button pressed.")
        let alertController = UIAlertController(title: "Familytree", message: "Do you want to save the familytree?", preferredStyle: .alert)
        let currentTopVC: UIViewController? = self.currentTopViewController()
        currentTopVC?.present(alertController, animated: true, completion: nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Ok alertbutton was pressed")
            if let itemsFromModel = self.familyTreeGenerator?.familyTree{
                var allDictionaries: [String:Any] = [:]
                var familyID = ""
                var humanID = ""
                print("itemsFromModel\(itemsFromModel)")
                for (key, Human) in itemsFromModel{
                    var parents: Dictionary<String, Any> = [:]
                    var dictionary = [
                        "name" : Human.name,
                        "gender" : Human.gender,
                        "dob" : Human.dob,
                        "patientID" : Human.patientID,
                        "id" : Human.id,
                        "processed" : Human.processed,
                        "showDiseaseInfo" : Human.showDiseaseInfo,
                        "parents" : Human.parents,
                        "children" : Human.children,
                        "siblings" : Human.siblings,
                        "spouses" : ["id1"]
                        ] as [String : Any]
                    
                    
                    allDictionaries[Human.id] = dictionary as [String:Any]
                    familyID = Human.patientID
                }
                
                print("")
                print("")
                
                var familyDictionary: [String:Any] = [:]
                familyDictionary[familyID] = allDictionaries
                print("print familyDict \(familyDictionary)")
                
                Alamofire.request("http://localhost:3000/api/savetree/",
                                  method: .post,
                                  parameters: familyDictionary,
                                  encoding: JSONEncoding.default) .responseJSON { (response) in
                                    switch response.result {
                                    case .success(let jsonData):
                                        print("Success \(jsonData)")
                                    case .failure(let error):
                                        print("error \(error)")
                                    }
                }
            }
            self.returnToView()
        }
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            print("No alertbutton was pressed")
            self.returnToView()
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }
    
    func returnToView() {
        self.performSegue(withIdentifier: "returnViewController", sender: nil)
    }
    
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
    
    func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
    

    
    func configureCollectionView() {
        
        let defaultCell = UINib(nibName: "iGenCell", bundle:nil)
        self.collectionView?.register(defaultCell, forCellWithReuseIdentifier: CustomCellIdentifiers.iGenCellID.rawValue)
        
    }
    
    /*
     
     - This function centers the patient cell in the middle of the screen. This happens in two steps:
     * Scroll to the patient cell and place it in the top left corner of the screen (xPos, yPos)
     * Offset the cell to the center of the screen (this differs per device) (xOffset, yOffset)
     
     @ xPos: Get x position of the patient cell
     @ yPos: Get y position of the patient cell
     @ xOffset: Get x offset for the specific device currently used
     @ yOffset: Get y offset for the specific device currently used
     
     */
    
    func centerFamilyTree(xOffset: CGFloat, yOffset: CGFloat) {
        
        self.collectionView?.contentOffset.x = xPos - (CGFloat(Constants.squareCellSize) * xOffset)
        self.collectionView?.contentOffset.y = yPos - (CGFloat(Constants.squareCellSize) * yOffset)
        
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
        print("didReceiveMemoryWarning")
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
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
        guard let cellContent = familyTreeGenerator?.model?.cell?[indexPath.section][indexPath.item] else {
            cell.bgImg.image = UIImage()
            return cell
        }
        
        // if this cell depicts a human, process it
        // if this human has a disease object, process it
        cell.bgImg.image = cellContent.switchBG()
        if let currentHuman = familyTreeGenerator?.familyTree[cellContent.getID()] {
            cell.processHumanCellFor(currentHuman)
            cell.genderImg.image = cellContent.showGender()
            if let currentDisease = familyTreeGenerator?.diseases[cellContent.getID()] {
                cell.processDiseaseCellFor(currentDisease)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cellContent = familyTreeGenerator?.model?.cell?[indexPath.section][indexPath.item],
            let currentHuman = familyTreeGenerator?.familyTree[cellContent.getID()] {
            
            let humanDetailsVC = storyboard!.instantiateViewController(withIdentifier: "HumanModDetailID") as! HumanModalViewController
            humanDetailsVC.humanDetails = familyTreeGenerator
            humanDetailsVC.indexPathForPerson = indexPath
            humanDetailsVC.transitioningDelegate = self
            //        humanDetailsVC.modalPresentationStyle = .overCurrentContext
            present(humanDetailsVC, animated: true, completion: nil)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if !onceOnly {
            
            switch device {
            case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus:
                centerFamilyTree(xOffset: 3.75, yOffset: 6.25)
                
            case .iPhone6, .iPhone6s, .iPhone7:
                centerFamilyTree(xOffset: 3.25, yOffset: 5.5)
                
            case .iPhone5, .iPhone5s, .iPhoneSE:
                centerFamilyTree(xOffset: 2.75, yOffset: 4.50)
                
            default:
                centerFamilyTree(xOffset: 2, yOffset: 3)
            }
            
            onceOnly = true
        }
    }
    
    deinit {
        print("deinit")
    }
    
}


extension CustomCollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.presenting = true
        return transition
    }
    
    
}
