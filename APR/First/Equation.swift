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
    let constantVector: Matrix
    
    mutating func solve(using decompositionMethod: DecompositionMethod? = .lup) -> Matrix? {
        var decomposer: Decomposer = decompositionMethod! == .lu ? LUDecomposer() : LUPDecomposer()
        do {
            try decomposer.decompose(matrix: &coefficientMatrix)
            let z = coefficientMatrix.backwardSubstitution(with: decomposer.permutationMatrix * constantVector)
            return coefficientMatrix.forwardSubstitution(with: z)
        } catch {
            print(error)
            return nil
        }
    }
}
