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
    @IBOutlet weak var stepCountLabel: UILabel!  // TODO: take this out eventually (not needed once circular progress bar done)
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var progressBar: CircularProgressBar!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var lapInputTextField: UITextField!
    @IBOutlet weak var marathonProgressBar: CircularProgressBar!
    @IBOutlet weak var todaysObjectivesLabel: UILabel!
    
    
    override func viewDidLoad() {
        // TODO:
        // - figure out constraints (for if using different devices ie. ipad vs iphone)
        // - fix layout when going from portrait to landscape
        // - connect with Apple Health to display step count
        // - connect with Player object to display correct name + streak info
        // - duplicate objectives labels + buttons and make them display correct objectives according to current player (another scrollview to do this?)
        super.viewDidLoad()
                
        // set up scrollview
        let pageWidth = scrollViewSteps.bounds.width
        let pageHeight = scrollViewSteps.bounds.height
        scrollViewSteps.contentSize = CGSize(width: 2*pageWidth, height: pageHeight)
        scrollViewSteps.isPagingEnabled = true
        scrollViewSteps.showsHorizontalScrollIndicator = false
        
        // add gradient background to scrollview
        scrollViewSteps.backgroundColor = UIColor.white
        gradientBackground(viewToModify: scrollViewSteps)

        // set up each scrollview screen
        let stepsDisplayView = buildStepDisplayView(width: pageWidth, height: pageHeight)
        let stepsAddView = buildStepInputView(width: pageWidth, height: pageHeight)
        
        // add two subviews to scrollview
        scrollViewSteps.addSubview(stepsDisplayView)
        scrollViewSteps.addSubview(stepsAddView)
        
        // add elements that are present on both scrollview screens
        view.addSubview(greetingsLabel)
        view.addSubview(streakLabel)
        view.addSubview(objectiveLabel)
        view.addSubview(checkBoxButton)
        view.addSubview(todaysObjectivesLabel)

        // set up scrollview delegate
        scrollViewSteps.delegate = self
        
        // set up textfield delegate
        stepInputTextField.delegate = self
        lapInputTextField.delegate = self
        
    }
    
    // adds a gradient background to the given view
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
    
    // builds the screen that displays step progress
    //
    // takes in the width and height of the scrollview and returns the finished view
    func buildStepDisplayView(width: CGFloat, height: CGFloat) -> UIView {
        let stepsDisplayView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))

        //Website I used to implement circular progress bar: https://codeburst.io/circular-progress-bar-in-ios-d06629700334
        progressBar.labelSize = 60
        //This is the percentage where the progress bar turns green
        progressBar.safePercent = 10;
        marathonProgressBar.labelSize = 60
        stepsDisplayView.addSubview(progressBar)
        stepsDisplayView.addSubview(marathonProgressBar)
        stepsDisplayView.addSubview(stepCountLabel)  // TODO: take this out eventually (once circlular progress bar done)

        
        return stepsDisplayView
    }
    
    // builds the screen that displays step input fields
    //
    // takes in the width and height of the scrollview and returns the finished view
    func buildStepInputView(width: CGFloat, height: CGFloat) -> UIView {
        let stepsAddView = UIView(frame: CGRect(x: width, y: 0, width: width, height: height))
        
        // give objective label rounded corners
        objectiveLabel.layer.cornerRadius = 10
        objectiveLabel.layer.masksToBounds = true
    
        // add all the elements to the step input screen
        stepsAddView.addSubview(stepInputTextField)
        stepsAddView.addSubview(lapInputTextField)
        stepsAddView.addSubview(orLabel)
        
        return stepsAddView
    }
    
    // hides the keyboard when the return button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // actions to complete when done editing either of the text fields (ie. return button pressed)
    func textFieldDidEndEditing(_ textField: UITextField) {
        // TODO: take out eventually and replace with circular progress bar
        // if the label is currently empty just put input text in label
        if(stepCountLabel.text == nil){
            stepCountLabel.text = stepInputTextField.text
        } else {
            // the label is not empty so add the input value to the label value
            stepCountLabel.text = String(    (stepInputTextField.text as! NSString).integerValue + (stepCountLabel.text as! NSString).integerValue)
        }
    
        //I'm pretending 200 steps is a lap. And the students goal is 1 lap. Right now, the progress bar is showing how close they are to their goal percentage wise.
        //I'll see if I can change it to where there's another circle showing how many laps / # goal laps the kid has done. Also I need to figure out what the inner
        //"marathon" circle means. Is it the percentage of how close they are to finishing one lap? Look up real values of stuff, and get real inputs.
        if((progressBar.setProgress(to: ((stepCountLabel.text as! NSString).doubleValue)/200, withAnimation:true) as! NSString).doubleValue != (stepCountLabel.text as! NSString).doubleValue){
            let valueWeDontCareAbout = progressBar.setProgress(to: ((stepCountLabel.text as! NSString).doubleValue)/200, withAnimation:true)
        }
        
        // reset the textfields
        stepInputTextField.text = ""
        lapInputTextField.text = ""
    }

}

