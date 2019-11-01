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
    var elements: [Double]
}

extension Matrix {
    
    func toString() -> String {
        var matrix = String()
        for row in 0..<dimensionM {
            for i in 0..<(dimensionN-1) {
                matrix.append(String(elements[row*dimensionN + i]) + " ")
            }
            matrix.append(String(elements[row*dimensionN + dimensionN-1]) + "\n")
        }
        return matrix
    }
    
//    func element(row: Int, )
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

        self.init(dimensionM: m, dimensionN: n, elements: elems)
    }
    
    func saveTo(_ path: String?) {
        guard let filePath = path else {
            fatalError("Unable to find a file with this path.")
        }
        let file = TextFile(path: Path(rawValue: filePath), encoding: .utf8)
        try? file.write(toString(), atomically: true)
    }

}



//        let data = "hello".data(using: .utf8)
//        do { try data?.write(to: fileUrl) } catch(error) {
//            print(error)
//        }

//        let fm = FileManager.default
//        fm.createFile(atPath: path, contents: nil, attributes: [FileAttributeKey.extensionHidden: true])
//        let fileURL = URL(fileURLWithPath: path)
//        let fileHandle = try? FileHandle(forWritingTo: fileURL)
//        print("\(path) was opened for writing")
//
//        fileHandle?.seekToEndOfFile()
//        fileHandle?.write(String("My name is Bob").data(using: .utf8)!)
//        fileHandle?.closeFile()

//
//        do {
//            let file = TextFile(path: Path(rawValue: path))
//            try file.write("My name is Bob.", atomically: true)
//        } catch {
//            print(error)
//        }
//
//func saveTo(path: String) {
//    let file = TextFile(path: Path(rawValue: path))
//    let _ = try? file.write(toString())

//func saveTo(path: String) {
//    let file = TextFile(path: Path(rawValue: path))
//    let _ = try? file.write(toString())
//}
