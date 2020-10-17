//
//  ArrayExtension.swift
//  APR
//
//  Created by Dunja Acimovic on 08/11/2019.
//  Copyright © 2019 Dunja Acimovic. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func switchElements(_ first: Int, _ second: Int) {
        let firstElement = self[first]
        self[first] = self[second]
        self[second] = firstElement
    }
}
