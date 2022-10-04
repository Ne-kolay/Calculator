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
    screen.text = "0"
}
    
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var sign: String = ""
    var result = Double()
    
    var firstNumberIsEntered = true //вводится ли сейчас первая цифра в числе
    var signIsselected: Bool = false //выбран ли знак
    var numberIsPositive: Bool = true //положительное ли число на экране
 
    @IBOutlet var screen: UILabel! //
    
    
    
    
    //вычисление результата сложения, вычитания, умножения или деления
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

        
    
//ввод цифр
    @IBAction func digitTapped(_ sender: UIButton) {
        //не позволяет ввести ещё один ноль в целой части, если на экране уже имеется ноль
        if (sender.tag == 0 && screen.text == "0") || (signIsselected == true && sender.tag == 0 && screen.text == "0") {
            return
        }
        if firstNumberIsEntered {                          //если это первая цифра в числе, заменяет содержимое экрана на эту цифру
            screen.text = String(sender.tag)
            firstNumberIsEntered = false
        } else {                                           //иначе, добавляет к числу на экране цифру справа
            screen.text = screen.text! + String(sender.tag)
        }
    }
    
    @IBAction func commaTapped(_ sender: UIButton) {  //вводит точку. надо заменить точку на запятую при выводе дробного числа на экран
        guard !firstNumberIsEntered else {return} //не позволяет ввести запятую первой в числе
        screen.text = screen.text! + "."
    }
    
    @IBAction func clearTapped(_ sender: UIButton) { //сброс
        firstNumber = 0
        secondNumber = 0
        sign = ""
        result = 0
        firstNumberIsEntered = true
        signIsselected = false
        numberIsPositive = true
        screen.text = "0"
    }
    
    @IBAction func changeNumberSignTapped(_ sender: UIButton) { //смена знака числа
        guard firstNumberIsEntered == false && screen.text != "0" else {return} // не позволяет поменять знак ещё не введённому числу и нулю или знаку
        guard screen.text != "+" && screen.text != "-" && screen.text != "*" && screen.text != "/" else {return}
        if numberIsPositive { // если число положительное, спереди добавится знак "-"
            screen.text = "-" + screen.text!
            numberIsPositive = false
        } else {
            screen.text!.remove(at: screen.text!.startIndex) //если число отрицательное, нажатие на кнопку удалит первый символ(знак "-")
            numberIsPositive = true
        }
    }
    
    //при расчёте процентов, некоторые дробные числа дают большое количество нулей после запятой. мб надо дописать округление до какого-то кол-ва знаков
    @IBAction func percentTapped(_ sender: UIButton) { //расчёт процентов
        // не позволяет расчитывать проценты, пока не выбран знак и не введено второе число
        guard signIsselected == true && screen.text != sign else {return}
        switch sign {
        case "+", "-":
            if ((firstNumber / 100) * Double(screen.text!)!).truncatingRemainder(dividingBy: 1) == 0 {
                screen.text = String(Int(((firstNumber / 100) * Double(screen.text!)!)))
            } else {
                screen.text = String((firstNumber / 100) * Double(screen.text!)!)
            }
        case "*", "/":
            screen.text = String(Double(screen.text!)! / 100)
        default:
            return
        }
    }
    
    @IBAction func mathSignTapped(_ sender: UIButton) { //ввод знака
        guard signIsselected == false else {return} //не позволяет ввести знак более одного раза
        guard screen.text?.isEmpty == false else {return} // не позволяет ввести знак в отсутствие первого числа
        
        firstNumber = Double(screen.text!)!
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
    
    
    @IBAction func equalsTapped(_ sender: UIButton) { // производит вычисления
        guard signIsselected == true && screen.text != sign else {return}
        secondNumber = Double(screen.text!)!
        result = calculation(firstElement: firstNumber, secondElement: secondNumber, sign: sign)
        if result.truncatingRemainder(dividingBy: 1) == 0 { //если дробная часть == 0, она не выводится на экран
            screen.text = String(Int(result))
        } else {
            screen.text = String(result) // если нет, выводим с дробной частью
        }
        numberIsPositive = true
    }
}



