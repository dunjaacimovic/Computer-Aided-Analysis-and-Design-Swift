//
//  MatrixRepresentation.swift
//  APR
//
//  Created by Dunja Acimovic on 01/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Cocoa
import Foundation
import FileKit


// Enables custom print for matrices
extension Matrix: CustomStringConvertible {
    var description: String {
        return self.toString()
    }
}

// MARK: Reading from and writing to a file
extension Matrix {
    
    // MARK: - Read and initalize new matrix from a file
    init(matrixPath: String?){
        guard let path = matrixPath, let elements = try? String(contentsOfFile: path) else {
            fatalError("Unable to read matrix from this path.")
        }
        
        // Split string and create a matrix
        let lines = elements.components(separatedBy: .newlines).compactMap{ $0 }
        let elems = lines.flatMap { (line) -> [Double] in
            line.components(separatedBy: .whitespaces)
                .compactMap({ Double($0) })
        }
        
        let n = lines[0].components(separatedBy: .whitespaces).count
        let m = elems.count / n
        
        self.init(rowCount: m, columnCount: n, elements: elems)
    }
    
    func saveTo(_ path: String?) {
        guard let filePath = path else {
            fatalError("Unable to find a file with this path.")
        }
        let file = TextFile(path: Path(rawValue: filePath), encoding: .utf8)
        try? file.write(toString(), atomically: true)
    }

}
