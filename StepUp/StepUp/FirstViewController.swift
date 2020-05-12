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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    }

}

