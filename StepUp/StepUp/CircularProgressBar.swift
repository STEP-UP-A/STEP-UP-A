//
//  CircularProgressBar.swift
//  StepUp
//
//  Created by Rithu Manoharan on 6/17/20.
//  Copyright © 2020 Rithu Manoharan. All rights reserved.
//

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//
//  CircularProgressBar.swift
//  attendance-manager
//
//  Created by Yogesh Manghnani on 02/05/18.
//  Copyright © 2018 Yogesh Manghnani. All rights reserved.

/*
   methods and variables associated with creation of circular progress bar
   Here's the website Rithu took this code from: https://codeburst.io/circular-progress-bar-in-ios-d06629700334
 */

import UIKit


class CircularProgressBar: UIView {
    
    //MARK: awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        label.text = "0"
    }
    
    
    //MARK: Public
    
    public var lineWidth:CGFloat = 50 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    public var labelSize: CGFloat = 20 {
        didSet {
            label.font = UIFont.systemFont(ofSize: labelSize)
            label.sizeToFit()
            configLabel()
        }
    }
    
    
    public var safePercent: Int = 100 {
        didSet{
             // Uncomment the commented lines of this method if you want this to be the point where the circular progress bar turns from red to green
            setForegroundLayerColorForSafePercent()
        }
    }
    
    // shows progress (percentage wise) towards goal
    // parameters - progressConstant: value from 0 to 1 representative of progress towards goal
    // return - double value equivalent to value of progressConstant
    public func setProgress(to progressConstant: Double, withAnimation: Bool) -> Double {
        
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        
        foregroundLayer.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = progress
            animation.duration = 2
            foregroundLayer.add(animation, forKey: "foregroundAnimation")
            //animation.fillMode = CAMediaTimingFillMode.forwards
            //animation.isRemovedOnCompletion = false
            
        }
        
        var progressPercent:Double = 0
        var currentTime:Double = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
            if currentTime >= 2{
                timer.invalidate()
            } else {
                currentTime += 0.05
                let percent = currentTime/2 * 100
                /*
                   progress percentage wise. useful if you want to change this label to number of laps, steps, miles, etc. instead.
                   For example, the following code can be used to show the number of laps for the progressBar:
                   self.label.text = "\(Int(progress * percent * (5/100)))". However, for the marathonProgressBar, different
                   code would be needed to show miles or some meaningful label that's not percentage. It might be tricky editing
                   this variable within the current organization of this class since different instances of the circular progress
                   bar require different labels. Potential solution: make label.text a public class variable?
                */
                self.label.text = "\(Int(progress * percent))%"
                progressPercent = progress * percent
                self.configLabel()
            }
        }
        timer.fire()
        return progressPercent
        
    }
    
    
    
    
    //MARK: Private
    private var label = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
            else { return (self.frame.height - lineWidth)/2 }
        }
    }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
    }
    
    private func drawForegroundLayer(){
        
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        //For below line: changed default from red to green
        foregroundLayer.strokeColor = UIColor.green.cgColor
        //Lolz I just commented the line below this out and the animation of the progress bar stays at the end NICE.
        //foregroundLayer.strokeEnd = 0
        
        self.layer.addSublayer(foregroundLayer)
        
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.font = UIFont.systemFont(ofSize: labelSize)
        label.sizeToFit()
        label.center = pathCenter
        return label
    }
    
    private func configLabel(){
        label.sizeToFit()
        label.center = pathCenter
    }
    
    // Uncomment the commented lines of this method if you want this to be the point where the circular progress bar turns from red to green.
    // The reason I took safePercent out is because the integer conversion of label prevents it from being more text descriptive.
    private func setForegroundLayerColorForSafePercent(){
    //    if Int(label.text!)! >= self.safePercent {
            self.foregroundLayer.strokeColor = UIColor.green.cgColor
    //    } else {
    //        self.foregroundLayer.strokeColor = UIColor.red.cgColor
    //    }
    }
    
    private func setupView() {
        makeBar()
        self.addSubview(label)
    }
    
    
    
    //Layout Sublayers
    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            let tempText = label.text
            setupView()
            label.text = tempText
            layoutDone = true
        }
    }
    
}
