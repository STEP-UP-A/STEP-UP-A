//
//  FirstViewController.swift
//  StepUp
//
//  This is the user step input screen loacted on the objectives screen
//
//  Created by Zach Grande on 4/20/20.
//  Copyright © 2020 Zach Grande. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var stepInputTextField: UITextField!
    @IBOutlet weak var stepCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

//        //Background
//        view.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
//
//        self.view.sendSubviewToBack(view)
//view.backgroundColor = .white
//
//
//let layer0 = CALayer()
//
//layer0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//
//layer0.bounds = view.bounds
//
//layer0.position = view.center
//
//view.layer.addSublayer(layer0)
//
//
//let layer1 = CAGradientLayer()
//
//layer1.colors = [
//
//  UIColor(red: 0.176, green: 0.612, blue: 0.859, alpha: 0.5).cgColor,
//
//  UIColor(red: 0.608, green: 0.318, blue: 0.878, alpha: 0).cgColor
//
//]
//
//layer1.locations = [0, 1]
//
//layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
//
//layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
//
//layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
//
//layer1.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
//
//layer1.position = view.center
//
//view.layer.addSublayer(layer1)
        
        // set up textfield delegate
        stepInputTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // do something with input text
        if(stepCountLabel.text == nil){
            stepCountLabel.text = stepInputTextField.text
        }
        else {
        stepCountLabel.text = String(    (stepInputTextField.text as! NSString).integerValue + (stepCountLabel.text as! NSString).integerValue)
        }

        
    }
    


}

