//
//  Matrix.swift
//  APR
//
//  Created by Dunja Acimovic on 26/10/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation
import FileKit

struct Matrix {
    var dimensionM: Int
    var dimensionN: Int
    var elements: [[Double]]
}

extension Matrix {

    public static func readToMatrixFromPath(_ matrixPath: String?) -> Matrix? {
        guard let path = matrixPath, let elements = try? String(contentsOfFile: path) else { return nil }
        
        // Split string and create a matrix
        let lines = elements.components(separatedBy: .newlines)
        let rows = lines.map {
            $0.components(separatedBy: .whitespaces)
                .compactMap({ Double($0) })
            }
            .filter { !$0.isEmpty }
        
        return Matrix(
            dimensionM: rows.count,
            dimensionN: rows[0].count,
            elements: rows
        )
    }
}
