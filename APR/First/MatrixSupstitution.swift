//
//  MatrixSupstitution.swift
//  APR
//
//  Created by Dunja Acimovic on 03/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation

extension Matrix {
    
    func forwardSubstitution(b: Matrix) -> Matrix {
        
        precondition(rowCount == columnCount, "Matrix is not square!")

        var y = Matrix(
            rowCount: self.rowCount,
            columnCount: 1,
            elements: b.elements
        )

        for i in 0..<rowCount-1 {
            for j in (i+1)..<columnCount {
                y[j, 0] -= self[j,i] * y[i, 0]
            }
        }
        return y
    }
    
    func backwardSubstitution(y: Matrix) -> Matrix {
        
        precondition(rowCount == columnCount, "Matrix is not square!")
        
        var x = Matrix(
            rowCount: self.rowCount,
            columnCount: 1,
            elements: y.elements
        )
        
        for i in (0..<rowCount).reversed() {
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
