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

    override func viewDidLoad() {

    }
    
    // This runs the data of the mystery point and makes a prediction. It outputs a Double between 0.0 and 1.0. The closer to 1.0 it is, the more the network thinks it's one type of flower, the closer to 0.0, the more the network thinks it's the other type of flower.
    func neural(m1: Double, m2: Double, w1: Double, w2: Double, b: Double)-> Double{
        return sigmoid(x: m1 * w1 + m2 * w2 + b)
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
