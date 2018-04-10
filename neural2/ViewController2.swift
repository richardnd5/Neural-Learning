//
//  ViewController.swift
//  neural2
//
//  Created by Nathan Richard on 4/8/18.
//  Copyright © 2018 Nathan Richard. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    var w1 = 0.5
    var w2 = 0.5
    var b = 0.5
    
    var m1 = 0.5
    var m2 = 0.5
    
    var target = 64.0
    var guess = 64.0
    var error = 0.0
    var learningRate = 0.02
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var xLine = UIView()
    var yLine = UIView()
    var point = UIView()

    
    var prediction = 0.0 {
        didSet {
            //            simpleNeural(pred: prediction, target: 4.0)
        }
    }
    var goal = 5.0
    
    var label = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xLine = UIView(frame: CGRect(x: 0, y: errorLabel.frame.maxY+200, width: view.frame.width, height: 1))
        xLine.backgroundColor = .black
        view.addSubview(xLine)
        
        point = UIView(frame: CGRect(x: view.frame.width/2, y: xLine.frame.midY-2, width: 4, height: 4))
        point.backgroundColor = .red
        view.addSubview(point)
        
        targetLabel.text = "\(target)"
        
    }
    
    
    @IBAction func targetSlider(_ sender: UISlider) {
        target = Double(sender.value)
        targetLabel.text = "\(target)"
        error = slopeDerived(pred: guess, target: target, learningRate: learningRate)
        errorLabel.text = "\(error)"
        point.frame.origin.y = xLine.frame.midY-CGFloat(error)-2.0
    }
    
    @IBAction func guessSlider(_ sender: UISlider) {
        guess = Double(sender.value)
        guessLabel.text = "\(guess)"
        error = slopeDerived(pred: guess, target: target, learningRate: learningRate)
        errorLabel.text = "\(error)"
        point.frame.origin.y = xLine.frame.midY-CGFloat(error)-2.0
    }
    

    
    // Neuron Functions
    // This is a simple perceptron. It takes 2 measurements, 2 weights, and 1 bias and returns a Double between 1 and 0
    func neural(m1: Double, m2: Double, w1: Double, w2: Double, b: Double)-> Double{
        
        return sigmoid(x: m1 * w1 + m2 * w2 + b)
    }
    
    func sigmoid(x: Double) -> Double{
        // This is the sigmoid function. Exp is the exponential function.
        return 1/(1 + exp(-x))
    }
    
    func squaredError(pred: Double, target: Double) -> Double{
        let n = pred - target
        return  pow(n,2)
    }
    
    func slopeNumerically(pred: Double, target: Double, learningRate: Double)->Double{
        return (squaredError(pred: pred+learningRate, target: goal)-squaredError(pred: pred, target: target))/learningRate
    }
    
    func slopeDerived(pred: Double, target: Double,  learningRate: Double)->Double{
        return (pred-target)*2
    }
    
    func findOptimalWeight(pred: Double, slope: Double, learningRate: Double){
        
    }
}


