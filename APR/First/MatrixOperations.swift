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

func /(lhs: Matrix, rhs: Double) -> Matrix {
    return Matrix(
        rowCount: lhs.rowCount,
        columnCount: lhs.columnCount,
        elements: lhs.elements.map{ $0 / rhs }
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

// MARK: - Compound Assignment Operators

func +=(lhs: inout Matrix, rhs: Matrix) {
    precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
    lhs.elements = zip(lhs.elements, rhs.elements).map(+)
}

func -=(lhs: inout Matrix, rhs: Matrix) {
    precondition(lhs.columnCount == rhs.columnCount && lhs.rowCount == rhs.rowCount, "Dimensions are wrong, unable to perform operation.")
    lhs.elements = zip(lhs.elements, rhs.elements).map(-)
}

extension Matrix {
    
    // Calculate inverse with LU decomposition
    func inv() -> Matrix? {
        
        guard abs(self.det()) > Matrix.allowedDiff else { print("Determinant is zero, therefore inverse matrix doesn't exist."); return nil }
        
        let identityMatrix = Matrix(rowCount: self.rowCount, columnCount: self.columnCount, identity: true)
        var inverseMatrix = Matrix(rowCount: self.rowCount, columnCount: self.columnCount)
        
        for i in 0..<columnCount {
            let constantVector = Matrix(rowCount: self.rowCount, columnCount: 1, elements: identityMatrix.getColumn(at: i))
            var equation = Equation(coefficientMatrix: self, constantsVector: constantVector)
            guard let inverseColumn = equation.solve() else { fatalError("Unable to calculate inverse") }
            inverseMatrix.setColumn(at: i, with: inverseColumn.elements)
        }
        
        return inverseMatrix
    }
    
    // Determinant
    func det() -> Double {
        
        // Decompose matrix
        var decomposedMatrix = self
        var decomposer = LUPDecomposer()
        do {
            try decomposer.decompose(matrix: &decomposedMatrix)
        } catch {
            print(error)
        }
        
        // Determinant
        var det = decomposedMatrix[0, 0]
        for i in 1..<rowCount {
            det *= decomposedMatrix[i, i]
        }
        
        det *= (decomposer.permutation.count - rowCount) % 2 == 0 ? 1 : -1
        return det
    }
    
    // Rank
    
    func rank() -> Int {
        let upperTriangleMatrix = self.upperTriangle()
        var rank = 0
        for i in 0..<rowCount {
            let result = upperTriangleMatrix[i].reduce(false) { (previousElement, element) -> Bool in
                return previousElement || (element != 0.0)
            }
            rank += result ? 1 : 0
        }
        return rank
    }
    
    // Augumented matrix
    func augument(with vector: Matrix) -> Matrix {
        precondition(vector.columnCount == 1, "Second argument needs to be a vector.")
        precondition(rowCount == vector.rowCount, "Matrix and vector need to have the same number of rows.")
        
        var augumentedMatrix = Matrix(rowCount: rowCount, columnCount: columnCount + 1)
        for i in 0..<augumentedMatrix.rowCount {
            augumentedMatrix[i] = self[i] + vector[i]
        }
        
        return augumentedMatrix
    }
    
    // MARK: - Elements manipulation -

    mutating func switchRows(_ a: Int, _ b: Int) {
        for i in 0..<columnCount {
            let x = self[a, i]
            self[a, i] = self[b, i]
            self[b, i] = x
        }
    }
    
    func upperTriangle(rounded: Bool? = true) -> Matrix {
        var upperTriangleMatrix = self
        
        // Square matrix
        if(rowCount == columnCount) {
            var decomposer = LUDecomposer()
            do {
                try decomposer.decompose(matrix: &upperTriangleMatrix)
            } catch { print(error) }
        
            for i in 0..<rowCount {
                for j in 0..<i {
                    upperTriangleMatrix[i, j] = 0.0
                }
            }
        } else {
            // Non-square matrix
            upperTriangleMatrix = self.gaussianElimination()
        }
        if rounded! { upperTriangleMatrix.elements = upperTriangleMatrix.elements.map { $0.rounded(to: 2) }}
        return upperTriangleMatrix
    }
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
    
    func gaussianElimination() -> Matrix {
        var matrix = self
        var column = 0
        
        for row in 0..<rowCount {
            var iMax = row
            for i in (row + 1)..<rowCount {
                if abs(matrix[i, column]) > abs(matrix[iMax, column]) {
                    iMax = i
                }
//            let iMax = self.getColumn(at: column).map(abs).reduce((-1, 0.0) ) { (max, current) -> (Int, Double) in
//                return current > max ? current : max
//            }
            }
            if iMax != row {
                matrix.switchRows(row, iMax)
            }
            
            for i in (row + 1)..<rowCount {
                let f = matrix[i, column] / matrix[row, column]
                for j in column..<columnCount {
                    matrix[i, j] -= matrix[row, j] * f
                }
            }
            column += 1
        }
        return matrix
    }
}



