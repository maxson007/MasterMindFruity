//
//  Result.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import Foundation
import SwiftUI

class Result: Identifiable{
    var id : Int
    var resultPlaced : [Color]
    var userSecretCode: [Int]
    
    init(id : Int,resultPlaced : [Color],userSecretCode: [Int]) {
        self.id = id
        self.resultPlaced=resultPlaced
        self.userSecretCode=userSecretCode
    }
}
