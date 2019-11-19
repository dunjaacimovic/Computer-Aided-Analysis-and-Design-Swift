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

    
// MARK: - Operators -

func +(lhs: Matrix, rhs: Matrix) -> Matrix {
    precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
    return Matrix(
        rowCount: lhs.rowCount,
        columnCount: lhs.columnCount,
        elements: zip(lhs.elements, rhs.elements).map(+)
    )
}

func -(lhs: Matrix, rhs: Matrix) -> Matrix {
    precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
    return Matrix(
        rowCount: lhs.rowCount,
        columnCount: lhs.columnCount,
        elements: zip(lhs.elements, rhs.elements).map(-)
    )
}

func *(lhs: Matrix, rhs: Matrix) -> Matrix {
    precondition(lhs.columnCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
    var result = Matrix(rowCount: lhs.rowCount, columnCount: rhs.columnCount)
    for r in 0..<lhs.rowCount {
        let lhsRow = lhs[r]
        for c in 0..<rhs.columnCount {
            let rhsColumn = rhs.getColumn(at: c)
            result[r,c] = zip(lhsRow, rhsColumn).map(*).reduce(0,+)
        }
    }
    return result
}

func *(lhs: Double, rhs: Matrix) -> Matrix {
    return Matrix(
        rowCount: rhs.rowCount,
        columnCount: rhs.columnCount,
        elements: rhs.elements.map{ $0 * lhs }
    )
}

prefix func ~(lhs: Matrix) -> Matrix {
    var result = Matrix(rowCount: lhs.columnCount, columnCount: lhs.rowCount)
    for r in 0..<lhs.rowCount {
        for c in 0..<lhs.columnCount {
            result[r, c] = lhs[c, r]
        }
    }
    return result
}

extension Matrix {
    
    // Calculate inverse with LU decomposition
    func inv() -> Matrix {
        
        let identityMatrix = Matrix(rowCount: self.rowCount, columnCount: self.columnCount, identity: true)
        var inverseMatrix = Matrix(rowCount: self.rowCount, columnCount: self.columnCount)
        
        for i in 0..<columnCount {
            let constantVector = Matrix(rowCount: self.rowCount, columnCount: 1, elements: identityMatrix.getColumn(at: i))
            var equation = Equation(coefficientMatrix: self, constantVector: constantVector)
            guard let inverseColumn = equation.solve() else { fatalError("Unable to calculate inverse") }
            inverseMatrix.setColumn(at: i, with: inverseColumn.elements)
        }
        
        return inverseMatrix
    }
}

// MARK: - Compound Assignment Operators

func +=(lhs: inout Matrix, rhs: Matrix) {
    precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
    lhs.elements = zip(lhs.elements, rhs.elements).map(+)
}

func -=(lhs: inout Matrix, rhs: Matrix) {
    precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
    lhs.elements = zip(lhs.elements, rhs.elements).map(-)
}

private extension Matrix {
    
    func getColumn(at c: Int) -> [Double] {
        var result: [Double] = []
        for r in 0..<rowCount { result.append(self[r, c]) }
        return result
    }
    
    mutating func setColumn(at c: Int, with column: [Double]) {
        for r in 0..<rowCount { self[r, c] = column[r] }
    }
}
