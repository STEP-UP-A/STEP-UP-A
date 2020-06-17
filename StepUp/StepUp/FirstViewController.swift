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
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var progressBar: CircularProgressBar!
    
    
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
        view.addSubview(greetingsLabel)

        // set up scrollview delegate
        scrollViewSteps.delegate = self
        
        // set up textfield delegate
        stepInputTextField.delegate = self
        
    }
    
    // adds a gradient background to the current view
    //
    // make sure to call this function before adding other elements to the view
    // or it will cover the labels/textfields/etc.
    func gradientBackground(viewToModify: UIView) {
        // set gradient background
        let layer0 = CALayer()
        layer0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer0.bounds = view.bounds
        layer0.position = view.center
        viewToModify.layer.addSublayer(layer0)
        
        let layer1 = CAGradientLayer()
        layer1.colors = [
            UIColor(red: 0.176, green: 0.612, blue: 0.859, alpha: 0.5).cgColor,
            UIColor(red: 0.608, green: 0.318, blue: 0.878, alpha: 0).cgColor
        ]
        layer1.locations = [0, 1]
        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        layer1.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer1.position = view.center
        viewToModify.layer.addSublayer(layer1)
    }
    
    func buildStepDisplayView(width: CGFloat, height: CGFloat) -> UIView {
        let stepsDisplayView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        stepsDisplayView.backgroundColor = UIColor.white
        gradientBackground(viewToModify: stepsDisplayView)

        //ELANA! HEY BUDDY! This is past Rithu :0. So the error I'm having is with the below line. I tried looking it up and doing the random
        //solutions people on stackOverflow suggested but nothing fixed it. I don't know why the progressBar just has a nil value when I followed the directions
        //here (https://codeburst.io/circular-progress-bar-in-ios-d06629700334) and I'm pretty sure I set it up right. It might be a problem with Xcode
        //not recognizing this custom class or something I need to change with the view?
        
        progressBar.setProgress(to: 1, withAnimation: true)
        stepsDisplayView.addSubview(progressBar)
        //stepsDisplayView.addSubview(stepCountLabel)

        
        return stepsDisplayView
    }
    
    func buildStepInputView(width: CGFloat, height: CGFloat) -> UIView {
        let stepsAddView = UIView(frame: CGRect(x: width, y: 0, width: width, height: height))
        stepsAddView.backgroundColor = UIColor.white
        gradientBackground(viewToModify: stepsAddView)
        
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

