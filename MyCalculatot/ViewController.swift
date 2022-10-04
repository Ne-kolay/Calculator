//
//  ViewController.swift
//  MyCalculatot
//
//  Created by Николай Савченко on 28.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var firstValue: Double = 0
    var secondValue: Double = 0
    var sign: String = ""
    var result = Double()
    
    var continueTyping = false
    var secondValueIsEntered: Bool = false
    var signIsselected: Bool = false
    
    func calculation (firstElement: Double, secondElement: Double, sign: String) -> Double {
        var result: Double
        switch sign {
        case "+":
            result = firstElement + secondElement
        case "-":
            result = firstElement - secondElement
        case "*":
            result = firstElement * secondElement
        case "/":
            result = firstElement / secondElement
        default:
            result = 0
        }
        return result
    }
    
    
    
    @IBOutlet var screen: UILabel!
    @IBOutlet var equalSign: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func digitTapped(_ sender: UIButton) {
        if continueTyping == false {
            screen.text = screen.text! + String(sender.tag)
        } else {
            screen.text = String(sender.tag)
            continueTyping = false
        }
    }
    
    
    @IBAction func mathSignTapped(_ sender: UIButton) {
        guard screen.text?.isEmpty == false else {return}
        firstValue = Double(screen.text!)!
        switch sender.tag {
        case 11:
            sign = "+"
            screen.text = "+"
        default:
            return
        }
        signIsselected = true
        continueTyping = true
    }
    
    
    
    
    
    
    
    
    
 
    
    @IBAction func plusTapped(_ sender: UIButton) {
        guard screen.text?.isEmpty == false else {return}
        firstValue = Double(screen.text!)!
        sign = "+"
        screen.text = "+"
        signIsselected = true
        continueTyping = true
    }
    @IBAction func minusTapped(_ sender: UIButton) {
        firstValue = Double(screen.text!)!
        sign = "-"
        screen.text = "-"
        signIsselected = true
    }
    @IBAction func multiplyTapped(_ sender: UIButton) {
        firstValue = Double(screen.text!)!
        sign = "*"
        screen.text = "*"
        signIsselected = true
    }
    @IBAction func divideTapped(_ sender: UIButton) {
        firstValue = Double(screen.text!)!
        sign = "/"
        screen.text = "/"
        signIsselected = true
    }
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        guard signIsselected == true && screen.text != sign else {return}
        secondValue = Double(screen.text!)!
        result = calculation(firstElement: firstValue, secondElement: secondValue, sign: sign)
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            screen.text = String(Int(result))
        } else {
            screen.text = String(result)
        }
        
        
    }
    
}
