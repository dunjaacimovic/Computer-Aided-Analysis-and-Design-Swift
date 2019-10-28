//
//  main.swift
//  APR
//
//  Created by Dunja Acimovic on 27/10/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation
import FileKit
//import AppKit
//
//let app = NSApplication.shared
//let appDelegate = AppDelegate()
//app.delegate = appDelegate
//_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

//let path = Path("/Examples/M1.txt")
let path = Bundle.main.path(forResource: "M1", ofType: "txt", inDirectory: "Examples")
//let fileHandle = Path(path!).fileHandleForReading
//
//let data = fileHandle?.availableData
//
//print(String(data: data!, encoding: .utf8))
//print(try? String(contentsOfFile: path))
let matrix = readToMatrixFromPath(path)
func zadatak1() {
    guard let mat = matrix else { return }
//    print(matrix?.elements[0][0].map { String($0) })
}
zadatak1()
//print(Matrix.readToMatrixFromPath(path))

