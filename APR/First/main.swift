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
let matrixC = Matrix(rowCount: 3, columnCount: 3, elements: [1, 1, 1, 1, 1, 1, 1, 1, 1])
let matrixD = Matrix(rowCount: 3, columnCount: 3, elements: [1, 1, 1, 0, 0, 0, 1, 1, 1])

let pathForWriting = Bundle.main.path(forResource: "M2", ofType: "txt", inDirectory: "Examples")
matrix.saveTo(pathForWriting)

func zadatak1() {
}
zadatak1()
