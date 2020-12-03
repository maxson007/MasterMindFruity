//
//  Game.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    @Published var history : [Result] = []
    var secretCode : [Int] = []
    let numberOfFruits=6;
    let level=4;
    var wellPlaced: Int = 0; //bien place
    var wrongPlace: Int = 0; //mal place
    var counter : Int = 0
    var resultPlaced: [Color]=[Color.gray,Color.gray,Color.gray,Color.gray]
    var userSecretCode:[Int]=[]
    public func generateSecret(){
        /*  for _ in 1 ... level {
         self.secretCode.append(generateIdentifier())
         }*/
        while(secretCode.count<level){
            let digit = generateIdentifier();
            if !secretCode.contains(digit){
                self.secretCode.append(digit)
            }
        }
        if !history.isEmpty{
            history.removeAll()
        }
        print(secretCode)
    }
    
    public func checkValueEnteredByUser(userValue: [Int]) -> Bool{
        self.userSecretCode=userValue
        counter+=1
        resultPlaced.removeAll()
        var secret = self.secretCode
        self.wellPlaced=0
        self.wrongPlace=0
        for i in 0 ..< level
        {
            if(secret[i] == userValue[i] ){
                self.wellPlaced+=1
                resultPlaced.append(Color.green)
                secret[i] = -1
            }
        }
        
        for i in 0 ..< level
        {
            if(secret.contains(userValue[i]) ){
                self.wrongPlace+=1
                resultPlaced.append(Color.red)
                if let index = secret.firstIndex(of: userValue[i]) {
                    secret[index] = -1
                }
            }
        }
        resultPlaced.shuffle()
        print(resultPlaced)
        secret.removeAll()
        print(userValue)
        history.append(Result(id: counter,resultPlaced: resultPlaced, userSecretCode: userValue))
        
        return isSuccess()
    }
    
    private func isSuccess() -> Bool{
        return self.wellPlaced == self.level
    }
    
    private func generateIdentifier() -> Int{
        return (Int(arc4random()) % self.numberOfFruits)+1
    }
}

