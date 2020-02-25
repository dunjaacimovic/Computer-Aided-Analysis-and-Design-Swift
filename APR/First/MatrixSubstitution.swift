//
//  MatrixSubstitution.swift
//  APR
//
//  Created by Dunja Acimovic on 03/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation

extension Matrix {
    
    func forwardSubstitution(with b: Matrix) -> Matrix {
        
        precondition(rowCount == columnCount, "Matrix is not square!")
        var y = b
        for i in 0..<(rowCount-1) {
            for j in (i+1)..<rowCount {
                y[j, 0] -= self[j,i] * y[i, 0]
            }
        }
        return y
    }
    
    func backwardSubstitution(with y: Matrix) -> Matrix {
        precondition(rowCount == columnCount, "Matrix is not square!")
        var x = y
        for i in (0...(rowCount-1)).reversed() {
            precondition(self[i, i] != 0, "Value of pivot element [\(i), \(i)] is 0")
            x[i, 0] = x[i, 0] / self[i,i];
            guard i > 0 else { break }
            for j in 0...(i-1) {
                x[j, 0] -= self[j, i] * x[i, 0]
            }
        }
        return x
    }
}
