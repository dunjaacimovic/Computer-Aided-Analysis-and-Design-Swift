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
    var rowCount: Int
    var columnCount: Int
    var elements: [Double]
    
    static let allowedDiff = 1e-7
}

extension Matrix {
    init(rowCount: Int, columnCount: Int, identity: Bool? = false) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        elements = Array(repeating: 0.0, count: rowCount*columnCount)
        
        // Creating identity matrix
        guard identity == true else { return }
        precondition(rowCount == columnCount, "Dimensions need to be equal for identity matrix.")
        for i in 0..<rowCount {
            elements[rowCount * i + i] = 1.0
        }
    }
}

// MARK: - Subscript -

extension Matrix {
    
    subscript(row: Int, column: Int) -> Double {
        get {
            return elements[row * columnCount + column]
        }
        set {
            elements[row * columnCount + column] = newValue
        }
    }
    
    subscript(row: Int) -> [Double] {
        get {
            return Array(elements[row*columnCount..<(row+1)*columnCount])
        }
        set {
            elements.replaceSubrange(row*columnCount..<(row+1)*columnCount, with: newValue)
        }
    }
}

// MARK: - Equatable -

extension Matrix: Equatable {
    
    static func ==(lhs: Matrix, rhs: Matrix) -> Bool {
        guard lhs.rowCount == rhs.rowCount, lhs.columnCount == rhs.columnCount else { return false }
        for r in 0..<lhs.rowCount {
            for c in 0..<lhs.columnCount {
                if lhs[r,c] - rhs[r,c] > allowedDiff { return false }
            }
        }
        return true
    }
}

// MARK: - Printing format -

extension Matrix: CustomStringConvertible {
    var description: String {
        return self.toString()
    }
    
    func toString() -> String {
        var matrix = String()
        var element = 0.0
        for row in 0..<rowCount {
            for i in 0..<(columnCount-1) {
                element = elements[row*columnCount + i] == -0.0 ? 0.0 : elements[row*columnCount + i]
                matrix.append(String(element) + " ")//.rounded(to: 2)) + " " )
            }
            element = elements[row*columnCount + columnCount-1] == -0.0 ? 0.0 : elements[row*columnCount + columnCount-1]
            matrix.append(String(element) + "\n") //.rounded(to: 2)) + "\n")
        }
        return matrix
    }
}

// MARK: - Write to and read from a file -

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

