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
    
    mutating func performOperation(_ symbol: String)  {
        
        switch symbol {
        case "π":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator {
                accumulator = operand.squareRoot()
            }
        default:
            break
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
}

