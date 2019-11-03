//
//  main.swift
//  APR
//
//  Created by Dunja Acimovic on 27/10/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation
import FileKit


let pathForReading = Bundle.main.path(forResource: "M1", ofType: "txt", inDirectory: "Examples")
var matrix = Matrix(matrixPath: pathForReading)
let matrixB = Matrix(rowCount: 3, columnCount: 4, elements: [1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1])
let matrixC = Matrix(rowCount: 3, columnCount: 3, elements: [1, 1, 1, 0, 0, 0, 1, 1, 1])
let matrixD = Matrix(rowCount: 3, columnCount: 3, elements: [1, 1, 1, 0, 0, 0, 1, 1, 1])

let pathForWriting = Bundle.main.path(forResource: "M2", ofType: "txt", inDirectory: "Examples")
matrix.saveTo(pathForWriting)

func zadatak1() {
    print(matrix[1,3])
    print(matrix.toString())
//
//    let A = Matrix(rowCount: 2, columnCount: 3, elements: [1, 2, 3, 4, 5, 6])
//    let B = Matrix(rowCount: 3, columnCount: 2, elements: [7, 8, 9, 10, 11, 12])
//
//    print(A * B)
    
//    print(matrix + matrixB)
//    matrix += matrixB
//    print(matrix)
//
//    print(matrix - matrixB)
//    matrix -= matrixB
//    print(matrix)
    
//    print(matrix[0])
//    matrix[0] = [1, 1, 1, 1]
//    print(matrix)
    
    print(matrixC == matrixD)
}
zadatak1()

//import AppKit
//
//let app = NSApplication.shared
//let appDelegate = AppDelegate()
//app.delegate = appDelegate
//_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

//let path = Path("/Examples/M1.txt")
//let fileHandle = Path(path!).fileHandleForReading
//
//let data = fileHandle?.availableData
//
//print(String(data: data!, encoding: .utf8))
//print(try? String(contentsOfFile: path))
//let path2 = Bundle.main.path(forResource: "M2", ofType: "txt", inDirectory: "Examples")
//let file = TextFile(path: Path(rawValue: filePath))
//let _ = try file.write("hello", atomically: true)
//print("hello")
//let urlForExamples = urlForResource.appendingPathComponent("MExamples/M2.txt")
//matrix.saveTo(urlForExamples)
//print(Matrix.readToMatrixFromPath(path))

//
//guard let urlForResource = Bundle.main.resourceURL else {
//    fatalError("Unable to open the resource directory.")
//}
