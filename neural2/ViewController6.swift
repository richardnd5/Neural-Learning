//
//  ViewController6.swift
//  neural2
//
//  Created by Nathan Richard on 4/11/18.
//  Copyright © 2018 Nathan Richard. All rights reserved.
//

import UIKit

class ViewController6: UIViewController {
    
    var weight1 = 0.5
    var bias = 1.0
    
    override func viewDidLoad() {
        
        // retrieving a value for a key
        if let data = UserDefaults.standard.data(forKey: "colors"),
            let savedColors = NSKeyedUnarchiver.unarchiveObject(with: data) as? [[Double]] {
            print(savedColors)
            for p in savedColors {
                colorArray.append(p)
            }
        } else {
            print("There is an issue")
        }
        
        displayedHue = Double(random(0.0, 0.91))
        colorView.backgroundColor = UIColor(hue: CGFloat(displayedHue), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        train()
        
        
    }
    

    
    func train() {
        
        // Need to start off with random weights
        weight1 = randomDouble(min: 0.0, max: 1.0)*0.2-0.1
        bias = randomDouble(min: 0.0, max: 1.0)*0.2-0.1
        let learningRate = 0.2
        
        for _ in 0..<50000 {
            
            // pick a random point from the database array
            let randomIndex = Int(randomDouble(min: 0, max: 1.0)*Double(colorArray.count))
            let point = colorArray[randomIndex]
            let m1 = point[0]
            let target = point[1]
            let dBias = 1.0
            
            // feed forward part of the network.
            // data*weight+bias
            let weightedSum = w1 * point[0] + b
            let pred = sigmoid(x: weightedSum)
            
            // now we find the slope of the cost with respect to each parameter (w1, w2, b)
            // bring derivative through square function
            let error = 2 * (pred - target)
            
            // bring derivative through sigmoid
            // derivative of sigmoid can be written using more sigmoids! d/dz sigmoid(z) = sigmoid(z)*(1-sigmoid(z))
            let dWeightedSum = sigmoid(x: weightedSum) * (1-sigmoid(x: weightedSum))
            
            // partial derivatives using the chain rule. This is the part I need help understanding.
            let dcost_dw1 = error * dWeightedSum * m1
            let dcost_db =  error * dWeightedSum * dBias
            
            // now we update our parameters.
            weight1 -= learningRate * dcost_dw1
            bias -= learningRate * dcost_db
        }
    }
    
    // This runs the data of the mystery point and makes a prediction. It outputs a Double between 0.0 and 1.0. The closer to 1.0 it is, the more the network thinks it's one type of flower, the closer to 0.0, the more the network thinks it's the other type of flower.
    func colorNeural(m1: Double,  w1: Double, b: Double)-> Double{
        return sigmoid(x: m1 * w1 + b)
    }
    
    // This is the sigmoid function. Exp is the exponential function.
    func sigmoid(x: Double) -> Double{
        return 1/(1 + exp(-x))
    }

    @IBOutlet weak var colorView: UIView!
    var colorArray = [[Double]]()
    
    @IBAction func redButton(_ sender: Any) {
        storeColor(colorType: 0.0)
    }
    @IBAction func orangeButton(_ sender: Any) {
        storeColor(colorType: 1.0)
    }
    @IBAction func yellowButton(_ sender: Any) {
        storeColor(colorType: 2.0)
    }
    @IBAction func greenButton(_ sender: Any) {
        storeColor(colorType: 3.0)
    }
    @IBAction func blueButton(_ sender: Any) {
        storeColor(colorType: 4.0)
    }
    @IBAction func purpleButton(_ sender: Any) {
        storeColor(colorType: 5.0)
    }
    @IBAction func pinkButton(_ sender: Any) {
        storeColor(colorType: 6.0)
    }
    
    func storeColor(colorType: Double) {
        colorArray.append([displayedHue, colorType])
        displayedHue = Double(random(0.0, 0.91))
        colorView.backgroundColor = UIColor(hue: CGFloat(displayedHue), saturation: 1.0, brightness: 1.0, alpha: 1.0)
//        print(colorArray)
        // setting a value for a key
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: colorArray)
        UserDefaults.standard.set(encodedData, forKey: "colors")
    }
    var displayedHue = 0.0
    
    func random(_ lowerLimit: CGFloat, _ upperLimit: CGFloat) -> CGFloat {
        return lowerLimit + CGFloat(arc4random()) / CGFloat(UInt32.max) * (upperLimit - lowerLimit)
    }

    func randomColor() -> UIColor {
        let r = random(0, 1)
        let g = random(0, 1)
        let b = random(0, 1)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    //Returns a random Double between 0.0 and 1.0
    func randomDouble(min: Double, max: Double) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
