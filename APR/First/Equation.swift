//
//  Equation.swift
//  APR
//
//  Created by Dunja Acimovic on 14/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation

struct Equation {
    
    var coefficientMatrix: Matrix
    let constantsVector: Matrix
    
    mutating func solve(using decompositionMethod: DecompositionMethod? = .lup, rounded: Bool? = true) -> Matrix? {
        var decomposer: Decomposer = decompositionMethod! == .lu ? LUDecomposer() : LUPDecomposer()
        do {
            try decomposer.decompose(matrix: &coefficientMatrix)
            let z = coefficientMatrix.forwardSubstitution(with: decomposer.permutation.matrix * constantsVector)
            var y = coefficientMatrix.backwardSubstitution(with: z)
            if rounded! { y.elements = y.elements.map { $0.rounded(to: 2) }}
            return y
        } catch {
            print("Could not decompose using ", (decompositionMethod! == .lu) ? "LU" : "LUP", " decomposition, because:", error)
            return nil
        }
    }
}
