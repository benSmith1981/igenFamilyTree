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
import IQKeyboardManager
import SVProgressHUD

protocol reloadAfterEdit: class {
    func reloadCell()
}

class CustomCollectionViewController: UICollectionViewController, reloadAfterEdit {
    
    var familyTreeGenerator: FamilyTreeGenerator?
    var answers = Answers()
    var alertView: UIAlertController?
    var human = Human.self
    let transition = PopAnimator()
    var onceOnly = false
    let device = Device()
    var xPos = CGFloat(Double((Constants.gridSize / 2)) * (Constants.squareCellSize))
    var yPos = CGFloat(Double((Constants.gridSize / 2)) * (Constants.squareCellSize))
    var selectedIndexPath: IndexPath?
    var serverResponse: ServerResponse?
    
    @IBAction func logOff(_ sender: Any) {
        UserDefaults.standard.setValue(nil, forKey: "username")
        UserDefaults.standard.setValue(nil, forKey: "userid")
        self.performSegue(withIdentifier: "returnViewController", sender: self)

    }
    func returnToView() {
        self.performSegue(withIdentifier: "returnViewController", sender: nil)
    }
    
    func reloadCell() {
        familyTreeGenerator?.makeModelFromTree()
        self.collectionView?.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(CustomCollectionViewController.getreeObserver),
                                             name:  Notification.Name(rawValue: NotificationIDs.getTreeID.rawValue),
                                             object: nil)
        IQKeyboardManager.shared().disabledToolbarClasses.add(CustomCollectionViewController.self)
        //        iGenDataService.parseiGenDiseaseData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(CustomCollectionViewController.notifyObserverDisease),
                                               name:  NSNotification.Name(rawValue: NotificationIDs.iGenDiseaseData.rawValue ),
                                               object: nil)
        
        // determine if entered via Login (already has userID and patientID) or via Register
        if serverResponse?.patientID == "" {
            registerFamilytree()
        } else {
            loginFamilytree()
        }
        //self.collectionView?.reloadData()
        
        configureCollectionView()
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        self.view.addGestureRecognizer(pinch)
        
    }
    
    func getreeObserver(notification: NSNotification) {
        SVProgressHUD.dismiss()
        let treeDict = notification.userInfo as! [String : Any]
        if let familyTree = treeDict["response"] as? [ID : Human] {
            if familyTree.isEmpty {
                print("no tree!!")
            } else {
                serverResponse?.familyTree = familyTree
                refreshFamilytree()
            }
            
        }
        
//        SVProgressHUD.dismiss()
//        let loginDict = notification.userInfo as! [String : Any]
//        print("notify observer Login \(loginDict)")
//        serverResponse = loginDict["response"] as? ServerResponse
//        if serverResponse == nil {
//            let serverResponse = loginDict["message"]
//            alertMessage(serverResponse as! String)
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    // extract patientID from the first Human for function MakeTreeFor
    // update the userID in the database and save the new familyTree to the database
    
    func refreshFamilytree() {
        if let firstKey = familyTreeGenerator?.familyTree.first?.key,
            let patientID = familyTreeGenerator?.familyTree[firstKey]?.patientID {
            familyTreeGenerator?.familyTree = (serverResponse?.familyTree)!
            familyTreeGenerator?.userID = patientID
            familyTreeGenerator?.username = (serverResponse?.username)!
            storeUsernameAndIDToDefaults()
            
            // load the diseases
            familyTreeGenerator?.loadDiseases()
            
            familyTreeGenerator?.makeTreeFor(patientID)
            familyTreeGenerator?.makeModelFromTree()
        } else {
            fatalError("Family tree not complete")
        }
    }
    
    func registerFamilytree() {
        if let firstKey = familyTreeGenerator?.familyTree.first?.key,
            let patientID = familyTreeGenerator?.familyTree[firstKey]?.patientID {
            familyTreeGenerator?.makeTreeFor(patientID)
            familyTreeGenerator?.makeModelFromTree()
            familyTreeGenerator?.userID = patientID
            familyTreeGenerator?.username = (serverResponse?.username)!
            storeUsernameAndIDToDefaults()
            let login = Login.init(username: (familyTreeGenerator?.username)!, password: "", PatientID: patientID, id: "")
            iGenDataService.updateUserID(withLogin: login)
            iGenDataService.saveFamilyTree((self.familyTreeGenerator?.familyTree)!)
        } else {
            fatalError("Family tree not complete")
        }
    }
    
    func loginFamilytree() {
        familyTreeGenerator = FamilyTreeGenerator.init(familyTree: [:])
        familyTreeGenerator?.familyTree = (serverResponse?.familyTree)!
        familyTreeGenerator?.userID = (serverResponse?.userID)!
        familyTreeGenerator?.username = (serverResponse?.username)!
        storeUsernameAndIDToDefaults()
        let patientID = (serverResponse?.patientID)!
        
        // load the diseases
        familyTreeGenerator?.loadDiseases()
        
        familyTreeGenerator?.makeTreeFor(patientID)
        familyTreeGenerator?.makeModelFromTree()
    }
    
    @IBAction func refreshTree(_ sender: Any) {
        if let firstKey = familyTreeGenerator?.familyTree.first?.key,
            let patientID = familyTreeGenerator?.familyTree[firstKey]?.patientID {
                SVProgressHUD.show()
                iGenDataService.getFamilyTree(patientID: patientID)
        }
    }
    
    func storeUsernameAndIDToDefaults() {
        UserDefaults.standard.setValue(familyTreeGenerator?.userID, forKey: "userid")
        UserDefaults.standard.setValue(familyTreeGenerator?.username, forKey: "username")
    }
    //  entered via iGenDataService
    func notifyObserverDisease(notification: NSNotification) {
        let diseaseDict = notification.userInfo as! [ID: Disease]
        // there is always exactly 1 disease notified
        let diseaseKey = diseaseDict.first?.key
        let diseaseValue = diseaseDict.first?.value
        familyTreeGenerator?.diseases[diseaseKey!] = diseaseValue
        self.collectionView?.reloadData()
        print("notify observer disease \(diseaseDict)")
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
    
    // MARK: - UICollectionViewDataSource
    
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
            print("cell=", indexPath.section, indexPath.item, cellContent, currentHuman.name, currentHuman.id)
            cell.processHumanCellFor(currentHuman, userID: (familyTreeGenerator?.userID)!)
            cell.genderImg.image = cellContent.showGender()
            if let currentDisease = familyTreeGenerator?.diseases[cellContent.getID()] {
                cell.processDiseaseCellFor(currentDisease)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedIndexPath = indexPath
        if let cellContent = familyTreeGenerator?.model?.cell?[indexPath.section][indexPath.item],
            let currentHuman = familyTreeGenerator?.familyTree[cellContent.getID()] {
            
            let humanDetailsVC = storyboard!.instantiateViewController(withIdentifier: "HumanModDetailID") as! HumanModalViewController
            humanDetailsVC.humanDetails = familyTreeGenerator
            humanDetailsVC.indexPathForPerson = indexPath
            humanDetailsVC.transitioningDelegate = self
            //        humanDetailsVC.modalPresentationStyle = .overCurrentContext
            humanDetailsVC.delegate = self
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
    
    //        func refreshCollectionView(){
    //            self.collectionView?.reloadData()
    //        }
    
}


extension CustomCollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.presenting = true
        return transition
    }
}

extension CustomCollectionViewController {
    
    // MARK: - Zoom stuff
    
    func handlePinch(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .ended || gesture.state == .changed {
            let trafo = CGAffineTransform.init(scaleX: gesture.scale, y: gesture.scale)
            self.collectionView?.transform = trafo
            if gesture.scale < 1.0 {
                self.collectionView?.frame = self.view.bounds
            }
        }
    }
}
