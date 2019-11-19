//
//  Decompositions.swift
//  APR
//
//  Created by Dunja Acimovic on 04/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation

// MARK: - Enums -

enum DecompositionMethod {
    case lu
    case lup
}

enum DecompositionError: Error {
    case notSquare
    case pivotIsZero
}

// MARK: - Decomposition -

//struct Decomposition {
//    
//    func decompose(matrix: Matrix, decompositionType: DecompositionMethod? = .lup) -> Matrix {
//        switch decompositionType! {
//        case .lu:
//            var decomposer = LUDecomposer()
//            var matrix = matrix
//            try? decomposer.decompose(matrix: &matrix)
//        case .lup:
//            var decomposer = LUPDecomposer()
//            var matrix = matrix
//            try? decomposer.decompose(matrix: &matrix)
//        }
//        return matrix
//    }
//}

// MARK: - Decomposer -

protocol Decomposer {
    var type: DecompositionMethod { get }
    var permutationMatrix: Matrix { get }
    mutating func decompose(matrix: inout Matrix) throws
}

struct LUDecomposer: Decomposer {
    
    // MARK: - Public properties
    
    var type = DecompositionMethod.lu
    var permutationMatrix: Matrix {
        guard let permutation = identityMatrix else { fatalError("Decomposition not done.") }
        return permutation
    }
    
    // MARK: - Private properties
    
    private var identityMatrix: Matrix?
    
    // MARK: - Methods
    
    mutating func decompose(matrix: inout Matrix) throws {

        guard matrix.rowCount == matrix.columnCount else { throw DecompositionError.notSquare }

        for i in 0..<(matrix.rowCount-1) {
            for j in i+1..<matrix.columnCount {
                guard matrix[i, i] != 0 else { throw DecompositionError.pivotIsZero }
                matrix[j, i] = matrix[j, i] / matrix[i, i]

                for k in (i+1)..<matrix.columnCount {
                    matrix[j, k] -= matrix[j, i] * matrix[i, k]
                }
            }
        }

        identityMatrix = Matrix(rowCount: matrix.rowCount, columnCount: matrix.columnCount, identity: true)
    }
    
}

struct LUPDecomposer: Decomposer {
    
    // MARK: - Public properties
    
    var type = DecompositionMethod.lup
    var permutationMatrix: Matrix {
        guard let permutation = permMatrix else { fatalError("Decomposition not done.") }
        return permutation
    }

    // MARK: - Private properties
    
    private var permMatrix: Matrix?
    
    // MARK: - Methods
    
    mutating func decompose(matrix: inout Matrix) throws {

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
            P.switchElements(i, pivot)
            for j in (i+1)..<matrix.rowCount {
                guard matrix[P[i], i] != 0 else { throw DecompositionError.pivotIsZero}
                matrix[P[j], i] = matrix[P[j], i] / matrix[P[i], i]
                for k in (i+1)..<matrix.rowCount {
                    matrix[P[j],k] -= matrix[P[j],i] * matrix[P[i],k];
                }
            }
        }
        
        permMatrix = createPermutationMatrix(with: P)
    }
    
    private func createPermutationMatrix(with pivots: [Int]) -> Matrix {
        var elements: [Double] = []
        for i in pivots {
            var row = Array(repeating: 0.0, count: pivots.count)
            row[i] = 1.0
            elements.append(contentsOf: row)
        }
        return Matrix(rowCount: pivots.count, columnCount: pivots.count, elements: elements)
    }
}
