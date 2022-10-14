//
//  ViewController.swift
//  Calculator
//
//  Created by Barkın Süngü on 27.09.2022.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var displayLabel: UILabel!
    @IBOutlet private weak var lastResultLabel: UILabel!
    
    var didOperandButtonTapped = false
    
    var currentOperand = ""
    
    var displayValue: String? {
        get {
            displayLabel.text
        }
        set {
            guard let newValue = newValue else {
                return
            }
            if displayLabel.text == "0" {
                displayLabel.text! = newValue
            } else {
                displayLabel.text! += newValue
            }
        }
    }
/*
    var numbers = [Double]() {
        didSet {
            print(numbers)
        }
    }*/
    var firstNumber = 0.0
    var secondNumber = 0.0
    var isEnd = false
    
    var result: String = "" {
        didSet {
            if result != "0" && result.last == "0"{
                result.popLast()
                result.popLast()
            }
            displayLabel.text = "\(result)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction private func digitButtonTapped(_ sender: UIButton){
        if isEnd{
            writeLastResult()
            isEnd = false
            displayLabel.text = ""
        }
        if didOperandButtonTapped {
            displayLabel.text = "0"
            didOperandButtonTapped = false
        }
        
        guard let currentTitle = sender.currentTitle else {
            return
        }
        displayValue = currentTitle
    }
    
    @IBAction private func operandButtonTapped(_ sender: UIButton){
        didOperandButtonTapped = true
        
        if isEnd{
            writeLastResult()
            isEnd = false
            displayLabel.text = ""
        }
        
        guard let displayValueInDouble = Double(displayValue ?? "0") else {
            return
        }
        firstNumber = displayValueInDouble
        
        guard let currentTitle = sender.currentTitle else {
            return
        }
        
        if currentTitle == "x!"{
            isEnd = true
            result = String(factorial(firstNumber: firstNumber))
            displayLabel.text = result
        }else if currentTitle == "√"{
            isEnd = true
            result = String(squareRoot(firstNumber: firstNumber))
            displayLabel.text = result
        }
        currentOperand = currentTitle
        
    }
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton){
        if isEnd{
            writeLastResult()
            isEnd = false
            displayLabel.text = ""
        }
        displayLabel.text = "0"
        didOperandButtonTapped = false
    }
    
    @IBAction private func equalButtonTapped(_ sender: UIButton){
        isEnd = true
        switch currentOperand {
        case "*":
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            secondNumber = displayValueInDouble
            
            result = String(multiply(firstNumber: firstNumber, secondNumber: secondNumber))
            displayLabel.text = result
            
        case "/":
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            secondNumber = displayValueInDouble
            
            result = String(divide(firstNumber: firstNumber, secondNumber: secondNumber))
            displayLabel.text = result
            
        case "-":
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            secondNumber = displayValueInDouble
            
            result = String(extraction(firstNumber: firstNumber, secondNumber: secondNumber))
            displayLabel.text = result
            
        case "+":
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            secondNumber = displayValueInDouble
            
            result = String(sum(firstNumber: firstNumber, secondNumber: secondNumber))
            displayLabel.text = result
        
        case "xʸ":
            guard let displayValueInDouble = Double(displayValue ?? "0") else {
                return
            }
            secondNumber = displayValueInDouble
            
            result = String(powerOf(firstNumber: firstNumber, secondNumber: secondNumber))
            displayLabel.text = result
            
        default:
            break
        }
    }
    
    @IBAction private func dotButtonTapped(_ sender: UIButton){
        if !(displayLabel.text?.contains(".") ?? true){
            displayValue = "."
        }
    }
        
    func sum(firstNumber: Double, secondNumber: Double) -> Double {
        firstNumber + secondNumber
    }
    
    func extraction(firstNumber: Double, secondNumber: Double) -> Double {
        firstNumber - secondNumber
    }
    
    func multiply(firstNumber: Double, secondNumber: Double) -> Double {
        firstNumber * secondNumber
    }
    
    func divide(firstNumber: Double, secondNumber: Double) -> Double {
        firstNumber / secondNumber
    }
    
    func powerOf(firstNumber: Double, secondNumber: Double) -> Double {
        pow(firstNumber, secondNumber)
    }
    
    func factorial(firstNumber: Double) -> Double {
        var result = 1
        if  firstNumber > 1{
            for i in 1...Int(firstNumber){
                result *= i
            }
        }
        return Double(result)
    }
    
    func squareRoot(firstNumber: Double) -> Double {
        sqrt(firstNumber)
    }
    
    func writeLastResult(){
        var firstNumber = String(firstNumber)
        var secondNumber = String(secondNumber)
        var result = result
        if firstNumber.last == "0" && firstNumber.contains("."){
            firstNumber.popLast()
            firstNumber.popLast()
        }
        if secondNumber.last == "0" && secondNumber.contains("."){
            secondNumber.popLast()
            secondNumber.popLast()
        }
        if result.last == "0" && result.contains("."){
            result.popLast()
            result.popLast()
        }
        if currentOperand == "x!"{
            lastResultLabel.text = "\(firstNumber)! = \(result)"
        }else if currentOperand == "√"{
            lastResultLabel.text = "√\(firstNumber) = \(result)"
        }else{
            lastResultLabel.text = "\(firstNumber) \(currentOperand) \(secondNumber) = \(result)"
        }
    }

}

