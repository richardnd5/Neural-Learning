//
//  ViewController.swift
//  neural2
//
//  Created by Nathan Richard on 4/8/18.
//  Copyright © 2018 Nathan Richard. All rights reserved.
//

import UIKit

class ViewController5: UIViewController {

    @IBOutlet weak var hueLabel: UILabel!
    
    var hue = CGFloat(0.5)
    
    @IBAction func hueSlider(_ sender: UISlider) {
        hue = CGFloat(sender.value)
        hueLabel.text = "\(hue)"
        colorBox.backgroundColor = UIColor(hue: CGFloat(hue), saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    @IBOutlet weak var colorBox: UIView!
    //unknown type (data we want to find)
    var dataU = [4.5,  1.0, 2.0];
    var all_points = [dataB1, dataB2, dataB3, dataB4, dataR1, dataR2, dataR3, dataR4];
    
    override func viewDidLoad() {

    }
    
    // This runs the data of the mystery point and makes a prediction. It outputs a Double between 0.0 and 1.0. The closer to 1.0 it is, the more the network thinks it's one type of flower, the closer to 0.0, the more the network thinks it's the other type of flower.
    func neural(m1: Double, m2: Double, w1: Double, w2: Double, b: Double)-> Double{
        return sigmoid(x: m1 * w1 + m2 * w2 + b)
    }
    
    func train() {
        
        // Need to start off with random weights
        w1 = randomDouble(min: 0.0, max: 1.0)*0.2-0.1
        w2 = randomDouble(min: 0.0, max: 1.0)*0.2-0.1
        b = randomDouble(min: 0.0, max: 1.0)*0.2-0.1
        let learningRate = 0.2
        
        for _ in 0..<50000 {
            
            // pick a random point from the database array
            let randomIndex = Int(randomDouble(min: 0, max: 1.0)*Double(all_points.count))
            let point = all_points[randomIndex]
            let m1 = point[0]
            let m2 = point[1]
            let target = point[2]
            let dBias = 1.0
            
            // feed forward part of the network.
            // data*weight+bias
            let weightedSum = w1 * point[0] + w2 * point[1] + b
            let pred = sigmoid(x: weightedSum)
            
            // now we find the slope of the cost with respect to each parameter (w1, w2, b)
            // bring derivative through square function
            let error = 2 * (pred - target)
            
            // bring derivative through sigmoid
            // derivative of sigmoid can be written using more sigmoids! d/dz sigmoid(z) = sigmoid(z)*(1-sigmoid(z))
            let dWeightedSum = sigmoid(x: weightedSum) * (1-sigmoid(x: weightedSum))
            
            // partial derivatives using the chain rule. This is the part I need help understanding.
            let dcost_dw1 = error * dWeightedSum * m1
            let dcost_dw2 = error * dWeightedSum * m2
            let dcost_db =  error * dWeightedSum * dBias
            
            // now we update our parameters.
            w1 -= learningRate * dcost_dw1
            w2 -= learningRate * dcost_dw2
            b -= learningRate * dcost_db
        }
    }
    
    // This is the sigmoid function. Exp is the exponential function.
    func sigmoid(x: Double) -> Double{
        return 1/(1 + exp(-x))
    }
    
    //Returns a random Double between 0.0 and 1.0
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }

}
