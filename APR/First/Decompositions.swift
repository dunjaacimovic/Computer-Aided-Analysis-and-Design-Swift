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

// MARK: - Decomposers -

protocol Decomposer {
    var type: DecompositionMethod { get }
    var permutation: Permutation { get }
    mutating func decompose(matrix: inout Matrix) throws
}

struct Permutation {
    var matrix: Matrix
    var count: Int
}

// MARK: - LU -
struct LUDecomposer: Decomposer {
    
    // MARK: - Public properties 
    
    var type = DecompositionMethod.lu
    var permutation: Permutation {
        guard let matrix = identityMatrix else { fatalError("Decomposition not done.") }
        return Permutation(matrix: matrix, count: 0)
    }
    
    // MARK: - Private properties
    
    private var identityMatrix: Matrix?
    
    // MARK: - Methods
    
    mutating func decompose(matrix: inout Matrix) throws {

//        guard matrix.rowCount == matrix.columnCount else { throw DecompositionError.notSquare }

        for i in 0..<(matrix.rowCount-1) {
            for j in i+1..<matrix.rowCount {
                guard matrix[i, i] != 0 else { throw DecompositionError.pivotIsZero }
                matrix[j, i] = matrix[j, i] / matrix[i, i]

                for k in (i+1)..<matrix.columnCount {
                    matrix[j, k] -= matrix[j, i] * matrix[i, k]
                }
            }
        }

        identityMatrix = Matrix(rowCount: matrix.rowCount, columnCount: matrix.rowCount, identity: true)
    }
    
}

// MARK: - LUP -

struct LUPDecomposer: Decomposer {
    
    // MARK: - Public properties
    
    var type = DecompositionMethod.lup
    var permutation: Permutation {
        guard var matrix = permutationMatrix else { fatalError("Decomposition not done.") }
        return Permutation(matrix: matrix, count: permutationCount)
    }
//    var permutationMatrix: Matrix {
//        guard let permutation = permMatrix else { fatalError("Decomposition not done.") }
//        return permutation
//    }
//    var permutationCount: Int {
//        guard let count = permCount else { fatalError("Decomposition not done.") }
//        return count
//    }

    // MARK: - Private properties
    
    private var permutationMatrix: Matrix?
    private var permutationCount = 0
    
    // MARK: - Methods
    
    mutating func decompose(matrix: inout Matrix) throws {

        var P = Array(repeating: 0, count: matrix.rowCount)

        for i in 0..<matrix.rowCount {
            P[i] = i
        }
        permutationCount = matrix.rowCount //count je incijaliziran s N

        for i in 0..<(matrix.rowCount - 1) {
            var pivot = i
            for j in (i+1)..<matrix.rowCount {
                if( abs(matrix[j, i]) > abs(matrix[pivot, i])) {
//                if( abs(matrix[P[j], i]) > abs(matrix[P[pivot], i])) {
                    pivot = j
                }
            }
            if pivot != i {
                P.switchElements(i, pivot)
                matrix.switchRows(i, pivot)
                permutationCount += 1
            }
            
            for j in (i+1)..<matrix.rowCount {
                guard matrix[i, i] != 0 else { throw DecompositionError.pivotIsZero }
//                guard matrix[P[i], i] != 0 else { throw DecompositionError.pivotIsZero }
                matrix[j, i] /= matrix[i, i]
//                matrix[P[j], i] /= matrix[P[i], i]
                for k in (i+1)..<matrix.columnCount {
                    matrix[j, k] -= matrix[j, i] * matrix[i, k]
//                    matrix[P[j],k] -= matrix[P[j],i] * matrix[P[i],k];
                }
            }
        }
        
        permutationMatrix = createPermutationMatrix(with: P)
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
