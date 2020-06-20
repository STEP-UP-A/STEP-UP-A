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
    @IBOutlet weak var stepCountLabel: UILabel!  // TODO: potentially take this out, add previous number of steps as gray text in textbox
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var progressBar: CircularProgressBar!
    @IBOutlet weak var streakLabel: UILabel!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var lapInputTextField: UITextField!
    @IBOutlet weak var marathonProgressBar: CircularProgressBar!
    @IBOutlet weak var todaysObjectivesLabel: UILabel!
    @IBOutlet weak var lapCountLabel: UILabel! // TODO: potentially take this out, add previous number of steps as gray text in textbox
    @IBOutlet weak var marathonLabel: UILabel!
    @IBOutlet weak var progressToGoalLapsLabel: UILabel!
    
    override func viewDidLoad() {
        // TODO:
        // - figure out constraints (for if using different devices ie. ipad vs iphone)
        // - fix layout when going from portrait to landscape
        // - connect with Apple Health to display step count
        // - connect with Player object to display correct name + streak info
        // - duplicate objectives labels + buttons and make them display correct objectives according to current player (another scrollview to do this?)
        // - double check laps-to-mile conversion and actual steps-lap conversion for circular progress bar
        // - implement actual number of goal laps (besides default of 5) based on objectives
        // - change text field editing so that it does not depend on label values
        // - format total count of steps and total count of laps
        // - way to make nested circular progress bars (see figma) ?
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
        
        // makes mutable labels blank initially
        // TODO: double check if this is the right place to set these initial values before anything is inputted
        stepCountLabel.text = ""
        lapCountLabel.text = ""
        progressToGoalLapsLabel.text = "0 / 5 Laps"

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

        // format elements
        progressBar.labelSize = 40
        marathonProgressBar.labelSize = 40
        marathonLabel.text = "Marathon"
        
        // add all the elements to the step display screen
        stepsDisplayView.addSubview(progressBar)
        stepsDisplayView.addSubview(marathonProgressBar)
        stepsDisplayView.addSubview(progressToGoalLapsLabel)
        stepsDisplayView.addSubview(marathonLabel)

        
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
        
        stepsAddView.addSubview(stepCountLabel)
        stepsAddView.addSubview(lapCountLabel)
        
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
        // TODO: Change the below two if-else statements so that its not dependent on the value of the labels
        // if the label is currently empty just put input text in label
        if(stepCountLabel.text == nil){
            stepCountLabel.text = stepInputTextField.text
        } else {
            // the label is not empty so add the input value to the label value
            stepCountLabel.text = String(    (stepInputTextField.text as! NSString).integerValue + (stepCountLabel.text as! NSString).integerValue)
        }
        
        // if the label is currently empty just put input text in label
        if(lapCountLabel.text == nil){
            lapCountLabel.text = lapInputTextField.text
        } else {
            // the label is not empty so add the input value to the label value
            lapCountLabel.text = String(    (lapInputTextField.text as! NSString).integerValue + (lapCountLabel.text as! NSString).integerValue)
        }
    
        // -updating circular progress bars-
        /* assuming 200 steps is a lap and the students goal is 5 laps. Right now, the progress bar is showing how close they are to their goal percentage wise.
           Currently, we don't know how many steps are in a lap. */
        let numSteps = (stepCountLabel.text as! NSString).doubleValue
        let inputLaps = (lapCountLabel.text as! NSString).doubleValue
        let numLaps = numSteps/200 + inputLaps
        let goalLaps = 5.0
        
        // -goal laps progress bar
        if(progressBar.setProgress(to: numLaps/goalLaps, withAnimation:true) != numLaps/goalLaps){
            // This value could be converted to something useful like number of laps and potentially shown in a label on the circular progress bar
            let currentProgressPercent = progressBar.setProgress(to: numLaps/goalLaps, withAnimation:true)
        }
        
        // assuming, from StepUpPoster on the drive, 10 laps is 1 mile and 26 miles is a marathon.
        let numMiles = numLaps/10.0
        
        // -marathon progress bar
        if(marathonProgressBar.setProgress(to: numMiles/26.0, withAnimation:true) != numMiles/26.0){
            // This value could be converted to something useful like number of miles and potentially shown in a label on the circular progress bar
            let currentMarathonProgressPercent = marathonProgressBar.setProgress(to: numMiles/26.0, withAnimation:true)
        }
        
        // displays number of lab completed out of a goal # of laps
        let integerNumLaps = Int(numLaps)
        progressToGoalLapsLabel.text = String(integerNumLaps) + " / 5 laps"
        
        // reset the textfields
        stepInputTextField.text = ""
        lapInputTextField.text = ""
    }

}

