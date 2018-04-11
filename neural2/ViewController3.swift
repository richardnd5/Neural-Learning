//
//  ViewController.swift
//  neural2
//
//  Created by Nathan Richard on 4/8/18.
//  Copyright © 2018 Nathan Richard. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    var w1 = 0.5
    var w2 = 0.5
    var b = 0.5
    
    var m1 = 0.5
    var m2 = 0.5
    
    var target = 64.0
    var guess = 64.0
    var error = 0.0
    var learningRate = 0.02
    
    var goal = 5.0
    
    var label = UILabel()
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var learningRateLabel: UILabel!
    @IBOutlet weak var adjustedNumberLabel: UILabel!
    
    @IBAction func learningRateSlider(_ sender: UISlider) {
        learningRate = Double(sender.value)
        learningRateLabel.text = "\(learningRate)"
    }
    
    @IBAction func targetSlider(_ sender: UISlider) {
        target = Double(sender.value)
        targetLabel.text = "\(target)"
        adjustedNumberLabel.text = "\(b)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustedNumberLabel.text = "\(b)"
        targetLabel.text = "64.0"
        learningRateLabel.text = "\(learningRate)"
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            let theGoal = findOptimalWeight(pred: b, learningRate: learningRate)
            b = theGoal
            adjustedNumberLabel.text = "\(theGoal)"
    }
    
    func slopeDerived(pred: Double, target: Double)->Double{
        return (pred-target)*2
    }
    //  Guess - (learningRate*((Guess-target)*2))
    func findOptimalWeight(pred: Double, learningRate: Double) -> Double{
        let slope = slopeDerived(pred: pred, target: target)
        return pred - (learningRate*slope)
    }

  
}


