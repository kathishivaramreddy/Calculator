//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by apple on 5/16/19.
//  Copyright © 2019 shivaapple. All rights reserved.
//

import Foundation

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
        "±": Operation.unaryOperation({-$0}),
        "×": Operation.binaryOperation({$0 * $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "-": Operation.binaryOperation({$0 - $1}),
        "/": Operation.binaryOperation({$0 / $1}),
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
            case .binaryOperation(let function):
                if let firstOperand = accumulator {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: firstOperand)
                }
            case .equals:
                perfromPendingBinaryOperation()
            }
        }
    }
    
    private mutating func perfromPendingBinaryOperation() {
        
        if pendingBinaryOperation != nil , accumulator != nil {
            accumulator =  pendingBinaryOperation?.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    private var pendingBinaryOperation : PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        
        let function:(Double,Double) ->  Double
        let firstOperand : Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
}

