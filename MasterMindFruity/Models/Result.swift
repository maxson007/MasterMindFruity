//
//  Result.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import Foundation
import SwiftUI

class Result: Identifiable, Hashable{
    
    static func == (lhs: Result, rhs: Result) -> Bool {
        return lhs.id==rhs.id
    }
    
    var id : Int
    var ID = UUID()
    var resultPlaced : [Color]
    var userSecretCode: [Int]
    
    init(id : Int,resultPlaced : [Color],userSecretCode: [Int]) {
        self.id = id
        self.resultPlaced=resultPlaced
        self.userSecretCode=userSecretCode
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.ID)
     }
}
