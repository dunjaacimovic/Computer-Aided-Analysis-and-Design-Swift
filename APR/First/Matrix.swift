//
//  Matrix.swift
//  APR
//
//  Created by Dunja Acimovic on 26/10/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation
import FileKit

struct Matrix {
    var rowCount: Int
    var columnCount: Int
    var elements: [Double]
}

// MARK: - Public functions -

extension Matrix {
    
    subscript(row: Int, column: Int) -> Double {
        get {
            return elements[row * columnCount + column]
        }
        set {
            elements[row * columnCount + column] = newValue
        }
    }
    
    subscript(row: Int) -> [Double] {
        get {
            return Array(elements[row*columnCount..<(row+1)*columnCount])
        }
        set {
            elements.replaceSubrange(row*columnCount..<(row+1)*columnCount, with: newValue)
        }
    }
    
    func toString() -> String {
        var matrix = String()
        for row in 0..<rowCount {
            for i in 0..<(columnCount-1) {
                matrix.append(String(elements[row*columnCount + i]) + " ")
            }
            matrix.append(String(elements[row*columnCount + columnCount-1]) + "\n")
        }
        return matrix
    }
}

extension Matrix: Equatable {
    
    static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.rowCount == rhs.rowCount
            && lhs.columnCount == rhs.columnCount
            && lhs.elements == rhs.elements
    }
}


