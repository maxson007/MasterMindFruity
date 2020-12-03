//
//  Game.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import Foundation
import SwiftUI

class Game: ObservableObject {
    @Published var history : [Result] = [] // tableau de stckage de l'historique d'une manche
    var secretCode : [Int] = [] // tableau de stockage du code secret
    let numberOfFruits=6; // nombre de fruit présent dans le panier
    let level=4; // niveau du code 4 pour un code à chiffre le niveau ne dois pas depasse le nombre de fruit
    var wellPlaced: Int = 0; // nombre de pions (fruit) bien place
    var wrongPlace: Int = 0; //nombre de pions (fruit ) mal place
    var counter : Int = 0 //compteur d'essai
    var resultPlaced: [Color]=[Color.gray,Color.gray,Color.gray,Color.gray] //tableau de stockage des pions bien placé et mal placé
    var userSecretCode:[Int]=[] // tableau de stockage teporaire du code saissie par l'utilisateur
    
    /* la fonction permet de génerer un code*/
    public func generateSecret(complexite: Level = .easy){
        switch complexite {
        case .easy:
            while(secretCode.count<level){
                let digit = generateIdentifier();
                if !secretCode.contains(digit){
                    self.secretCode.append(digit)
                }
            }
            break
            
        case .hard , .medium:
            for _ in 1 ... level {
                self.secretCode.append(generateIdentifier())
            }
            break
        }
        
        if !history.isEmpty{
            history.removeAll()
        }
        print(secretCode)
    }
    
    /* la fonction permet de verifier le code saisi*/
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
    
    /* generation d'un identifiant compris entre 1 et 6 */
    private func generateIdentifier() -> Int{
        return (Int(arc4random()) % self.numberOfFruits)+1
    }
}

/*  niveau */
enum Level {
    case easy,medium,hard
}
