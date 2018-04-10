//
//  ViewController.swift
//  neural2
//
//  Created by Nathan Richard on 4/8/18.
//  Copyright © 2018 Nathan Richard. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    var w1 = 0.5
    var w2 = 0.5
    var b = 0.5
    
    var m1 = 0.5
    var m2 = 0.5

    @IBAction func m1Slider(_ sender: UISlider) {
        m1Label.text = "\(sender.value)"
        m1 = Double(sender.value)
        PredictionLabel.text = "\(neural(m1: m1, m2: m2, w1: w1, w2: w2, b: b))"
    }
    
    @IBAction func m2Slider(_ sender: UISlider) {
        m2Label.text = "\(sender.value)"
        m2 = Double(sender.value)
        PredictionLabel.text = "\(neural(m1: m1, m2: m2, w1: w1, w2: w2, b: b))"
    }
    
    @IBAction func w1Slider(_ sender: UISlider) {
        w1Label.text = "\(sender.value)"
        w1 = Double(sender.value)
        PredictionLabel.text = "\(neural(m1: m1, m2: m2, w1: w1, w2: w2, b: b))"
    }
    
    @IBAction func w2Slider(_ sender: UISlider) {
        w2Label.text = "\(sender.value)"
        w2 = Double(sender.value)
        PredictionLabel.text = "\(neural(m1: m1, m2: m2, w1: w1, w2: w2, b: b))"
    }
    
    @IBAction func biasSlider(_ sender: UISlider) {
        biasLabel.text = "\(sender.value)"
        b = Double(sender.value)
        PredictionLabel.text = "\(neural(m1: m1, m2: m2, w1: w1, w2: w2, b: b))"
    }
    
    @IBOutlet weak var m1Label: UILabel!
    @IBOutlet weak var m2Label: UILabel!
    @IBOutlet weak var w1Label: UILabel!
    @IBOutlet weak var w2Label: UILabel!
    @IBOutlet weak var biasLabel: UILabel!
    @IBOutlet weak var PredictionLabel: UILabel!
    
    var prediction = 0.0 {
        didSet {
//            simpleNeural(pred: prediction, target: 4.0)
        }
    }
    var goal = 5.0
    
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        makeUIElements()
        
    }
    
    func makeUIElements() {
        
        let slider = UISlider(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: 20))
        slider.backgroundColor = .black
        slider.maximumValue = 10
        slider.minimumValue = -6
        slider.addTarget(self, action: #selector(ViewController1.sliderValueDidChange(_:)), for: .valueChanged)
        view.addSubview(slider)
        
        label = UILabel(frame: CGRect(x: 0, y: slider.frame.maxY, width: view.frame.width, height: 100))
        label.font = UIFont(name: "Verdana", size: 12)
        label.numberOfLines = 4
        label.textAlignment = .center
        view.addSubview(label)
        
    }
    
    func makeSliderAndLabel(frame: CGRect) {
        
        let slider = UISlider(frame: frame)
        slider.backgroundColor = .black
        slider.maximumValue = 10
        slider.minimumValue = -6
        slider.tag = 1
        slider.addTarget(self, action: #selector(ViewController1.sliderValueDidChange(_:)), for: .valueChanged)
        view.addSubview(slider)
        
        label = UILabel(frame: CGRect(x: 0, y: slider.frame.maxY, width: view.frame.width, height: 100))
        label.font = UIFont(name: "Verdana", size: 12)
        label.numberOfLines = 4
        label.textAlignment = .center
        label.text = "Label!"
        view.addSubview(label)
        
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        prediction = Double(sender.value)
        
//        let forString1 = slopeNumerically(pred: prediction, target: goal, learningRate: 0.1)
//        let forString2 = slopeDerived(pred:prediction, target: goal, h: 0.1)
//        label.text = "Target is: \(goal)\n Prediction: \(prediction) \n slopeNumberically : \(forString1) \n slopeDerived: \(forString2)"
        
//        let forString1 = squaredError(pred: prediction, target: goal)
//        label.text = "Target is: \(goal)\n Prediction: \(prediction) \n This is the squared error : \(forString1)"

//            label.text = "run the neuron: \(neural(m1: prediction, m2: m2, w1: w1, w2: w2, b: b))"
        
//        label.text = "slider value: \(prediction) sigmoid of slider value:  \(sigmoid(x: prediction))"
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
}

