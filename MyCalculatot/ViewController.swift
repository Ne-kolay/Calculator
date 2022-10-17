//
//  ViewController.swift
//  MyCalculatot
//
//  Created by Николай Савченко on 28.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.text = ""
        for button in allButtons {
            if button.tag <= 9 {
                continue
            }
            button.isEnabled = false
        }
    }
    
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var sign: String = ""
    
    var firstDigitEntering = true //вводится ли сейчас первая цифра в числе
    var signIsSelected: Bool = false //выбран ли знак
    
    
    @IBOutlet var screen: UILabel! //
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet var mathSignButtons: [UIButton]!
    @IBOutlet var equalButton: UIButton!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var signChangeButton: UIButton!
    @IBOutlet var commaButton: UIButton!
    @IBOutlet var percentButton: UIButton!
    
    
    
    
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
    
    
    
    @IBAction func digitTapped(_ sender: UIButton) {
        guard screen.text!.count < 10 else {return}
        
        if firstDigitEntering {
            screen.text = String(sender.tag)
            clearButton.isEnabled = true
            commaButton.isEnabled = true
            firstDigitEntering = false
            
            if !signIsSelected {
                for button in mathSignButtons {
                    button.isEnabled = true
                }
            } else {
                equalButton.isEnabled = true
                percentButton.isEnabled = true
            }
        } else {
            if screen.text == "0" {
                if sender.tag == 0 {
                    return
                } else {
                    screen.text = String(sender.tag)
                }
            } else {
                screen.text = screen.text! + String(sender.tag)
            }
            
        }
        
        if screen.text != "0" && screen.text != "0." && Double(screen.text!)! != 0.0 {
            signChangeButton.isEnabled = true
        }
    }
    
    
    @IBAction func commaTapped(_ sender: UIButton) {
        screen.text = screen.text! + "."
        commaButton.isEnabled = false
        firstDigitEntering = false
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        sign = ""
        firstDigitEntering = true
        signIsSelected = false
        screen.text = ""
        for button in allButtons {
            if button.tag <= 9 {
                button.isEnabled = true
            } else {
                button.isEnabled = false
            }
        }
    }
    
    @IBAction func changeNumberSignTapped(_ sender: UIButton) {
        //другой вариант блокировки кнопки смены знака
        //guard Double(screen.text!)! != 0.0 else {screen.text = "0"; signChangeButton.isEnabled = false; return} — так ведёт себя оригинальный калькулятор
        //guard Double(screen.text!)! != 0.0 else {return}

        if screen.text![screen.text!.startIndex] != "-"{
            screen.text = "-" + screen.text!
        } else {
            screen.text!.remove(at: screen.text!.startIndex)
        }
    }
    
    @IBAction func percentTapped(_ sender: UIButton) {
        guard signIsSelected == true && screen.text != sign else {return}
        
        switch sign {
        case "+", "-":
            if ((firstNumber / 100) * Double(screen.text!)!).truncatingRemainder(dividingBy: 1) == 0 {
                screen.text = String(Int(((firstNumber / 100) * Double(screen.text!)!)))
                
                
                //screen.text = String(Int(((firstNumber / 100) * Double(screen.text!)!)))
            } else {
                screen.text = String((firstNumber / 100) * Double(screen.text!)!)
            }
        case "*", "/":
            screen.text = String(Double(screen.text!)! / 100)
        default:
            return
        }
    }
    
    @IBAction func mathSignTapped(_ sender: UIButton) {
        guard signIsSelected == false else {return}
        
        firstNumber = Double(screen.text!)!
        signIsSelected = true
        firstDigitEntering = true
        signChangeButton.isEnabled = false
        
        for mathSignButton in mathSignButtons {
            mathSignButton.isEnabled = false
        }
        
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
        
    }
    
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        secondNumber = Double(screen.text!)!
        
        if calculation(firstElement: firstNumber, secondElement: secondNumber, sign: sign).truncatingRemainder(dividingBy: 1) == 0 {
            var result = String(calculation(firstElement: firstNumber, secondElement: secondNumber, sign: sign))
            result.removeSubrange(result.index(result.startIndex, offsetBy: result.count - 2)...result.index(result.startIndex, offsetBy: result.count - 1))
            screen.text = result
        } else {
            screen.text = String((calculation(firstElement: firstNumber, secondElement: secondNumber, sign: sign) * 1000000000).rounded() / 1000000000)
        }
        clearButton.isEnabled = true
        for button in allButtons {
            if button.tag == 15 {
                button.isEnabled = true
            } else {
                button.isEnabled = false
            }
        }
    }
}


