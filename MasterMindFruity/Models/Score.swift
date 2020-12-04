//
//  Score.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 04/12/2020.
//

import Foundation

struct Score {
    private var playerNumberOfPoint: Int = 0
    private var systemNumberOfPoint: Int = 0
    
    var player : Int {
        get{
            return playerNumberOfPoint*3
        }
    }
    
    var system : Int {
        get{
            return systemNumberOfPoint*3
        }
    }
    
    public mutating func incrementScorePlayer(){
         self.playerNumberOfPoint += 1
    }
    
    public mutating func incrementScoreSystem(){
        self.systemNumberOfPoint += 1
    }
}
