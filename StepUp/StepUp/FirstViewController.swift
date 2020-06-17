//
//  FirstViewController.swift
//  StepUp
//
//  This is the user step input screen loacted on the objectives screen
//
//  Created by Rithu Manoharan & Elana Hummel on 4/20/20.
//  Copyright © 2020 Rithu Manoharan & Elana Hummel. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet weak var scrollViewSteps: UIScrollView!
    @IBOutlet weak var stepInputTextField: UITextField!
    @IBOutlet weak var stepCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set up scrollview
        let pageWidth = scrollViewSteps.bounds.width
        let pageHeight = scrollViewSteps.bounds.height

        scrollViewSteps.contentSize = CGSize(width: 2*pageWidth, height: pageHeight)
        scrollViewSteps.isPagingEnabled = true
        scrollViewSteps.showsHorizontalScrollIndicator = false

        let stepsDisplayView = buildStepDisplayView(width: pageWidth, height: pageHeight)
        let stepsAddView = buildStepInputView(width: pageWidth, height: pageHeight)
    

        scrollViewSteps.addSubview(stepsDisplayView)
        scrollViewSteps.addSubview(stepsAddView)

        // set up scrollview delegate
        scrollViewSteps.delegate = self
        
        // set up textfield delegate
        stepInputTextField.delegate = self
        
    }
    
    func buildStepDisplayView(width: CGFloat, height: CGFloat) -> UIView {
        let stepsDisplayView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        stepsDisplayView.backgroundColor = UIColor.blue
        stepsDisplayView.addSubview(stepCountLabel)
        
        return stepsDisplayView
    }
    
    func buildStepInputView(width: CGFloat, height: CGFloat) -> UIView {
        let stepsAddView = UIView(frame: CGRect(x: width, y: 0, width: width, height: height))
        stepsAddView.backgroundColor = UIColor.orange
        stepsAddView.addSubview(stepInputTextField)
        
        return stepsAddView
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

