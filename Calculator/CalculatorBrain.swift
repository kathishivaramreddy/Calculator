//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by apple on 5/16/19.
//  Copyright © 2019 shivaapple. All rights reserved.
//

import Foundation

func multiply(operand1: Double, operand2: Double) -> Double {
    return (operand1 * operand2)
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    var result: Double? {
        get {
            return accumulator!
        }
    }
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "×": Operation.binaryOperation(multiply),
        "=": Operation.equals
        
    ]
    mutating func performOperation(_ symbol: String)  {
        
        if let operation = operations[symbol] {
            switch operation {
                case .constant(let value):
                    accumulator = value
            case .unaryOperation(let function):
                if let operand = accumulator {
                    accumulator = function(operand)
                }
            default:
                break
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
}

