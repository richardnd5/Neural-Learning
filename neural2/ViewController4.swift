//
//  ViewController.swift
//  neural2
//
//  Created by Nathan Richard on 4/8/18.
//  Copyright © 2018 Nathan Richard. All rights reserved.
//

import UIKit

// This is the training set. [length, width, color(0=blue and 1=red)]. Data usually comes in a .csv file. Here, it is parsed out into an array.
// dataB(x) are the blue flowers. dataR(x) are the red flowers.
var dataB1 = [1.0, 1.0, 0.0];
var dataB2 = [2.0, 1.0,   0.0];
var dataB3 = [2.0, 0.5, 0.0];
var dataB4 = [3.0,  1.0, 0.0];

var dataR1 = [3.0, 1.5, 1.0];
var dataR2 = [3.5,   0.5, 1.0];
var dataR3 = [4.0, 1.5, 1.0];
var dataR4 = [5.5,   1.0,   1.0];

var w1 = Double()
var w2 = Double()
var b = Double()

var m1 = 5.0
var m2 = 5.0

class ViewController4: UIViewController {

    @IBOutlet weak var m1Label: UILabel!
    @IBOutlet weak var m2Label: UILabel!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    //unknown type (data we want to find)
    var dataU = [4.5,  1.0, 2.0];
    var all_points = [dataB1, dataB2, dataB3, dataB4, dataR1, dataR2, dataR3, dataR4];
    
    override func viewDidLoad() {
        train()
        print(neural(m1: 5.0, m2: 5.0, w1: w1, w2: w2, b: b))
        
        dataLabel.text = "m1: 1, m2: 1 = Blue\nm1: 2, m2: 1 = Blue\nm1: 2, m2: 0.5 = Blue\nm1: 3, m2: 1 = Blue\nm1:3.0, m2: 1.5 = Red\nm1:3.5, m2: 0.5 = Red\nm1:4.0, m2: 1.5 = Red\nm1:5.5, m2: 1.0 = Red"
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
    
    func blueOrRed(){
        if neural(m1: m1, m2: m2, w1: w1, w2: w2, b: b) > 0.5 {
            predictionLabel.text = "Based on the data you just put in with the slider, the point is probably red!"
            predictionLabel.backgroundColor = UIColor(hue: 0.02, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        } else {
            predictionLabel.text = "Based on the data you just put in with the slider, the point is probably blue!"
            predictionLabel.backgroundColor = UIColor(hue: 0.7, saturation: 1.0, brightness: 1.0, alpha: 1.0)
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
    
    @IBAction func m1Slider(_ sender: UISlider) {
        m1 = Double(sender.value)
        m1Label.text = "\(m1)"
        blueOrRed()
    }
    
    @IBAction func m2Slider(_ sender: UISlider) {
        m2 = Double(sender.value)
        m2Label.text = "\(m2)"
        blueOrRed()
    }
}
