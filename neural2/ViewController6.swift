//
//  ViewController6.swift
//  neural2
//
//  Created by Nathan Richard on 4/11/18.
//  Copyright © 2018 Nathan Richard. All rights reserved.
//

import UIKit

class ViewController6: UIViewController {
    
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

//    func randomHue() {
//        displayedHue =  UIColor(hue: random(0.0, 1.0), saturation: 1.0, brightness: 1.0, alpha: 1.0)
//    }
    func randomColor() -> UIColor {
        let r = random(0, 1)
        let g = random(0, 1)
        let b = random(0, 1)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
