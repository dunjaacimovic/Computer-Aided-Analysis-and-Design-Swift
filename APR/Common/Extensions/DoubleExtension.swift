//
//  DoubleExtension.swift
//  APR
//
//  Created by Dunja Acimovic on 03/12/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//
import Foundation

extension Double {
    
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
