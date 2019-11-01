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
let matrix = Matrix(matrixPath: path)

let pathForWriting = Bundle.main.path(forResource: "M2", ofType: "txt", inDirectory: "Examples")
matrix.saveTo(pathForWriting)

func zadatak1() {
    //    print(matrix.elements[0][0])
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
