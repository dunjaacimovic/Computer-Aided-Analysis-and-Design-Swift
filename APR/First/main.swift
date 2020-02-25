//
//  main.swift
//  APR
//
//  Created by Dunja Acimovic on 27/10/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation
import FileKit

//let diagonal: Bool? = nil
//
////let pathForReading = Bundle.main.path(forResource: "M1", ofType: "txt", inDirectory: "Examples")
////var matrix = Matrix(matrixPath: pathForReading)
//let matrixB = Matrix(rowCount: 3, columnCount: 4, elements: [1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1])
//let matrixC = Matrix(rowCount: 3, columnCount: 3, elements: [1, 1, 1, 1, 1, 1, 1, 1, 1])
//let matrixD = Matrix(rowCount: 3, columnCount: 3, elements: [1, 1, 1, 0, 0, 0, 1, 1, 1])
//let matrixE = Matrix(rowCount: 3, columnCount: 3, identity: true)
//
////let pathForWriting = Bundle.main.path(forResource: "M2", ofType: "txt", inDirectory: "Examples")
////matrix.saveTo(pathForWriting)
////
////var writtenMatrix = Matrix(matrixPath: pathForReading)
////print(matrix==writtenMatrix)
//
//var m = Matrix(rowCount: 2, columnCount: 2, elements: [4, 3, 6, 3])
//var decomposer = LUDecomposer()
//try decomposer.decompose(matrix: &m)
//
//print(m)
//
//m = Matrix(rowCount: 2, columnCount: 2, elements: [4, 3, 6, 3])
//var lupDecomposer = LUPDecomposer()
//try lupDecomposer.decompose(matrix: &m)
//
//print(m)


// MARK: - Zadatak 1: Usporedba double vrijednosti -

func zadatak1() {
    let pathForMatrix = Bundle.main.path(forResource: "M1", ofType: "txt", inDirectory: "Examples")
    let realNumbersMatrix = Matrix(matrixPath: pathForMatrix)
  
    let resultMatrix = (0.23 * realNumbersMatrix) / 0.23

    // Print results
    print("Real number matrix:")
    print(realNumbersMatrix)
    print("Result matrix:")
    print(resultMatrix)
    print("Equality: ")
    print(realNumbersMatrix == resultMatrix)
    print("\n")
}

print("\nZADATAK 1:\n")
zadatak1()


// MARK: - Zadatak 2: Rjesenje sustava LU i LUP dekompozicijom -

func zadatak2() {
    let pathForCoefficients = Bundle.main.path(forResource: "M2", ofType: "txt", inDirectory: "Examples")
    let pathForConstants = Bundle.main.path(forResource: "M3", ofType: "txt", inDirectory: "Examples")

    let coefficientMatrix = Matrix(matrixPath: pathForCoefficients)    
    let constantsVector = Matrix(matrixPath: pathForConstants)
    
    var luEquation = Equation(coefficientMatrix: coefficientMatrix, constantsVector: constantsVector)
    var lupEquation = Equation(coefficientMatrix: coefficientMatrix, constantsVector: constantsVector)
    
    let luSolution = luEquation.solve(using: .lu)
    let lupSolution = lupEquation.solve(using: .lup)

    print(luSolution ?? "")
    print(lupSolution ?? "")
}

print("\nZADATAK 2:\n")
zadatak2()

// MARK: - Zadatak 3: Postojanje rjesenja sustava jednadzbi -

func zadatak3() {
    let pathForCoefficients = Bundle.main.path(forResource: "M4", ofType: "txt", inDirectory: "Examples")
    let coefficientsMatrix = Matrix(matrixPath: pathForCoefficients)
    print(coefficientsMatrix)
    
    print(coefficientsMatrix.upperTriangle())
    print(coefficientsMatrix.rank())
    
    let pathForConstants = Bundle.main.path(forResource: "M13", ofType: "txt", inDirectory: "Examples")
    let constantsVector = Matrix(matrixPath: pathForConstants)
    
    let augumentedMatrix = coefficientsMatrix.augument(with: constantsVector)
    print(augumentedMatrix)
    
    print(augumentedMatrix.upperTriangle())
    print(augumentedMatrix.rank())
}

print("\nZADATAK 3:\n")
zadatak3()

// MARK: - Zadatak 4: Usporedba LU i LUP rjesenja kod double vrijednosti

func zadatak4() {
    let pathForCoefficients = Bundle.main.path(forResource: "M5", ofType: "txt", inDirectory: "Examples")
    let pathForConstants = Bundle.main.path(forResource: "M6", ofType: "txt", inDirectory: "Examples")
    
    let coefficientsMatrix = Matrix(matrixPath: pathForCoefficients)
    let constantsVector = Matrix(matrixPath: pathForConstants)
    
    var luEquation = Equation(coefficientMatrix: coefficientsMatrix, constantsVector: constantsVector)
    var lupEquation = Equation(coefficientMatrix: coefficientsMatrix, constantsVector: constantsVector)
    
    let luSolution = luEquation.solve(using: .lu, rounded: false)
    let lupSolution = lupEquation.solve(using: .lup, rounded: false)
    
    print(luSolution ?? "")
    print(lupSolution ?? "")
    
}

print("\nZADATAK 4:\n")
zadatak4()

// MARK: - Zadatak 5: Rjesavanje sustava -

func zadatak5() {
    let pathForCoefficients = Bundle.main.path(forResource: "M7", ofType: "txt", inDirectory: "Examples")
    let pathForConstants = Bundle.main.path(forResource: "M8", ofType: "txt", inDirectory: "Examples")
    
    let coefficientMatrix = Matrix(matrixPath: pathForCoefficients)
    let constantsVector = Matrix(matrixPath: pathForConstants)
    
    var lupEquation = Equation(coefficientMatrix: coefficientMatrix, constantsVector: constantsVector)
    let lupSolution = lupEquation.solve(using: .lup)
    
    print(lupSolution ?? "")
}

print("\nZADATAK 5:\n")
zadatak5()

// MARK: - Zadatak 6: Rjesavanje sustava -

func zadatak6() {
    let pathForCoefficients = Bundle.main.path(forResource: "M9", ofType: "txt", inDirectory: "Examples")
    let pathForConstants = Bundle.main.path(forResource: "M10", ofType: "txt", inDirectory: "Examples")
    
    let coefficientMatrix = Matrix(matrixPath: pathForCoefficients)
    let constantsVector = Matrix(matrixPath: pathForConstants)
    
    var lupEquation = Equation(coefficientMatrix: coefficientMatrix, constantsVector: constantsVector)
    let lupSolution = lupEquation.solve(using: .lup)
    
    print(lupSolution ?? "")
}

print("\nZADATAK 6:\n")
zadatak6()

// MARK: - Zadatak 7: Inverz matrice -

func zadatak7() {
    let pathForMatrix = Bundle.main.path(forResource: "M11", ofType: "txt", inDirectory: "Examples")
    let matrix = Matrix(matrixPath: pathForMatrix)
    
    guard let inverse = matrix.inv() else { return }
    print(inverse)
}

print("\nZADATAK 7:\n")
zadatak7()

// MARK: - Zadatak 8: Inverz matrice -

func zadatak8() {
    let pathForMatrix = Bundle.main.path(forResource: "M12", ofType: "txt", inDirectory: "Examples")
    let matrix = Matrix(matrixPath: pathForMatrix)
    
    guard let inverse = matrix.inv() else { return }
    print(inverse)
}

print("\nZADATAK 8:\n")
zadatak8()

// MARK: - Zadatak 9: Determinanta koristenjem LUP dekompozicije -

func zadatak9() {
    let pathForMatrix = Bundle.main.path(forResource: "M12", ofType: "txt", inDirectory: "Examples")
    let matrix = Matrix(matrixPath: pathForMatrix)
    
    print(matrix.det())
}

print("\nZADATAK 9:\n")
zadatak9()


// MARK: - Zadatak 10: Determinanta koristenjem LUP dekompozicije -

func zadatak10() {
    let pathForMatrix = Bundle.main.path(forResource: "M2", ofType: "txt", inDirectory: "Examples")
    let matrix = Matrix(matrixPath: pathForMatrix)
     
    print(matrix.det())
}

print("\nZADATAK 10:\n")
zadatak10()


// PROBA
//print("Proba:")
//let pathForMatrix = Bundle.main.path(forResource: "P1", ofType: "txt", inDirectory: "Examples")
//let matrix = Matrix(matrixPath: pathForMatrix)
//
//let pathForVector = Bundle.main.path(forResource: "P2", ofType: "txt", inDirectory: "Examples")
//let vector = Matrix(matrixPath: pathForVector)
//
//let result = matrix.backwardSubstitution(with: vector)
//print(result)

//let pathForMatrix = Bundle.main.path(forResource: "P3", ofType: "txt", inDirectory: "Examples")
//let matrix = Matrix(matrixPath: pathForMatrix)
//
//let pathForVector = Bundle.main.path(forResource: "P4", ofType: "txt", inDirectory: "Examples")
//let vector = Matrix(matrixPath: pathForVector)
//
//let result = matrix.forwardSubstitution(with: vector)
//print(result)

//
//print(matrix)
//
//var decomposedMatrix = matrix
//var decomposerExample = LUDecomposer()
//do {
//    try decomposerExample.decompose(matrix: &decomposedMatrix)
//    print(decomposedMatrix)
//} catch { print(error) }
