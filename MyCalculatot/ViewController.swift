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
    
    var firstNumberIsEntered = true
    var secondValueIsEntered: Bool = false
    var signIsselected: Bool = false
    var numberIsPositive: Bool = true
    
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
        if firstNumberIsEntered {
            screen.text = String(sender.tag)
            firstNumberIsEntered = false
        } else {
            screen.text = screen.text! + String(sender.tag)
        }
    }
    
    @IBAction func commaTapped(_ sender: UIButton) {
        guard !firstNumberIsEntered else {return}
        screen.text = screen.text! + "."
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        firstValue = 0
        secondValue = 0
        sign = ""
        result = 0
        firstNumberIsEntered = true
        secondValueIsEntered = false
        signIsselected = false
        numberIsPositive = true
        screen.text = ""
    }
    
    @IBAction func changeNumberSignTapped(_ sender: UIButton) {
        guard firstNumberIsEntered == false && screen.text != "0" else {return}
        guard screen.text != "+" && screen.text != "-" && screen.text != "*" && screen.text != "/" else {return}
        if numberIsPositive {
            screen.text = "-" + screen.text!
            numberIsPositive = false
        } else {
            screen.text!.remove(at: screen.text!.startIndex)
            numberIsPositive = true
        }
    }
    
    
    
    
    @IBAction func mathSignTapped(_ sender: UIButton) {
        guard signIsselected == false else {return}
        guard screen.text?.isEmpty == false else {return}
        
        firstValue = Double(screen.text!)!
        switch sender.tag {
        case 10:
            sign = "+"
            screen.text = "+"
        case 11:
            sign = "-"
            screen.text = "-"
        case 12:
            sign = "*"
            screen.text = "*"
        case 13:
            sign = "/"
            screen.text = "/"
        default:
            return
        }
        signIsselected = true
        firstNumberIsEntered = true
        numberIsPositive = true
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
        numberIsPositive = true
        
        
    }
    
}
