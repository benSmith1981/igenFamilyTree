//
//  StartScreen.swift
//  iGenFamilyTree
//
//  Created by Paul Geurts on 02/08/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {
    
    fileprivate var rootViewController: UIViewController? = nil

    var gradientLayer: CAGradientLayer!
    var colorSets = [[CGColor]]()
    var currentColorSet: Int!
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.frame
        gradientLayer.startPoint = CGPoint(x: 0.0,y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)
        gradientLayer.colors = colorSets[currentColorSet]
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func createColorSets() {
        colorSets.append([UIColor(red:0.99, green:0.35, blue:0.36, alpha:1.0).cgColor, UIColor(red:0.96, green:0.36, blue:0.65, alpha:1.0).cgColor])
        colorSets.append([UIColor(red:0.87, green:0.36, blue:0.54, alpha:1.0).cgColor, UIColor(red:0.97, green:0.73, blue:0.58, alpha:1.0).cgColor])
        
        currentColorSet = 0
    }
  
    func playAnimation() {
 
        if currentColorSet < colorSets.count - 1 {
            currentColorSet! += 1
        }
        else {
            currentColorSet = 0
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NavigationControllerID") as! NavigationControllerID
            self.present(nextViewController, animated:true, completion:nil)
            //let loginScreen = self.storyboard!.instantiateViewController(withIdentifier: "NavigationControllerID") as! NavigationControllerID
            //self.present(loginScreen, animated: true, completion: nil)
            
        })
        
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = 1.5
        colorChangeAnimation.toValue = colorSets[currentColorSet]
        colorChangeAnimation.fillMode = kCAFillModeForwards
        colorChangeAnimation.isRemovedOnCompletion = false
        
        gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
        CATransaction.commit()

    }
    
    public func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
//    func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        if flag {
//            gradientLayer.colors = colorSets[currentColorSet]
////            if currentColorSet > 3 {
////             playAnimation()
////            } else {
////                self.performSegue(withIdentifier: "Main", sender: self)
////            }
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        createGradientLayer()
        playAnimation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createColorSets()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
