//
//  Decompositions.swift
//  APR
//
//  Created by Dunja Acimovic on 04/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation

enum DecomposeError: Error {
    case pivotIsZero
    case matrixNotSquare
}

struct LUDecomposer {
    
    mutating func decompose(matrix: inout Matrix) throws -> Matrix  {
        
        guard matrix.rowCount == matrix.columnCount else { throw DecomposeError.matrixNotSquare }
        
        for i in 0..<(matrix.rowCount-1) {
            for j in i+1..<matrix.columnCount {
                guard matrix[i, i] != 0 else { throw DecomposeError.pivotIsZero }
                matrix[j, i] = matrix[j, i] / matrix[i, i]
                
                for k in (i+1)..<matrix.columnCount {
                    matrix[j, k] -= matrix[j, i] * matrix[i, k]
                }
            }
        }
        
        return matrix
    }
}

struct LUPDecomposer {
    
    mutating func decompose(matrix: inout Matrix) throws -> Matrix {
        
        var P = Array(repeating: 0, count: matrix.rowCount)
        
        for i in 0..<matrix.rowCount {
            P[i] = i
        }
        
        for i in 0..<(matrix.rowCount - 1) {
            var pivot = i
            for j in (i+1)..<matrix.rowCount {
                if( abs(matrix[P[j], i]) > abs(matrix[P[pivot], i])) {
                    pivot = j
                }
            }
            P = replaceElements(of: P, first: i, second: pivot)
            for j in (i+1)..<matrix.rowCount {
                guard matrix[P[i], i] != 0 else { throw DecomposeError.pivotIsZero}
                matrix[P[j], i] = matrix[P[j], i] / matrix[P[i], i]
                for k in (i+1)..<matrix.rowCount {
                    matrix[P[j],k] -= matrix[P[j],i] * matrix[P[i],k];                }
            }
        }
        return matrix
    }
}

func replaceElements(of array: [Int], first: Int, second: Int) -> [Int] {
    var newArray = array
    newArray[first] = array[second]
    newArray[second] = array[first]
    return array
}
