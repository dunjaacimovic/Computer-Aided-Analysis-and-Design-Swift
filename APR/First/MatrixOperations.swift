//
//  MatrixOperations.swift
//  APR
//
//  Created by Dunja Acimovic on 03/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Cocoa
import Foundation
import FileKit

extension Matrix {
    
    // MARK: - Operators -
    
    static func +(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
        return Matrix(
            rowCount: lhs.rowCount,
            columnCount: lhs.columnCount,
            elements: zip(lhs.elements, rhs.elements).map(+)
        )
    }
    
    static func -(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
        return Matrix(
            rowCount: lhs.rowCount,
            columnCount: lhs.columnCount,
            elements: zip(lhs.elements, rhs.elements).map(-)
        )
    }
    
    static func *(lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.columnCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
        return multiply(A: lhs, B: rhs)
    }
    
    static func *(lhs: Double, rhs: Matrix) -> Matrix {
        return Matrix(
            rowCount: rhs.rowCount,
            columnCount: rhs.columnCount,
            elements: rhs.elements.map{ $0 * lhs }
        )
    }
    
    static prefix func ~(lhs: Matrix) -> Matrix {
        var result = Matrix(rowCount: lhs.columnCount, columnCount: lhs.rowCount, elements: Array(repeating: 0.0, count: lhs.columnCount*lhs.rowCount))
        for r in 0..<lhs.rowCount {
            for c in 0..<lhs.columnCount {
                result[r, c] = lhs[c, r]
            }
        }
        return result
    }
    
    // MARK: - Compound Assignment Operators
    
    static func +=(lhs: inout Matrix, rhs: Matrix) {
        precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
        lhs.elements = zip(lhs.elements, rhs.elements).map(+)
    }
    
    static func -=(lhs: inout Matrix, rhs: Matrix) {
        precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
        lhs.elements = zip(lhs.elements, rhs.elements).map(-)
    }
}

// MARK: - Private methods -

private extension Matrix {
    
    static func multiply(A: Matrix, B: Matrix) -> Matrix {
        
        var result = Matrix(rowCount: A.rowCount, columnCount: B.columnCount, elements: Array(repeating: 0.0, count: A.rowCount*B.columnCount))
        for r in 0..<A.rowCount {
            let rowA = A[r]
            for c in 0..<B.columnCount {
                let columnB = B.getColumn(at: c)
                result[r,c] = zip(rowA, columnB).map(*).reduce(0,+)
            }
        }
        return result
    }
    
    func getColumn(at c: Int) -> [Double] {
        var result: [Double] = []
        for r in 0..<rowCount { result.append(self[r, c]) }
        return result
    }
}
