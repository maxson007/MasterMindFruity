//
//  Game.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import Foundation
import SwiftUI

/*  niveau */
enum Level {
    case easy,medium,hard
}

class Game: ObservableObject {
    @Published var history : [Result] = [] // tableau de l'historique d'une manche
    var secretCode : [Int] = [] // tableau de stockage du code secret
    let numberOfFruits=6; // nombre de fruit présent dans le panier
    var secretCodeLength : Int = 4; // nombre maximun de pions pour construire le code secret
    var wellPlaced: Int = 0; // nombre de pions (fruit) bien place
    var wrongPlaced: Int = 0; //nombre de pions (fruit ) mal place
    var counter : Int = 0 //compteur d'essai
    var resultPlaced: [Color]=[Color.gray,Color.gray,Color.gray,Color.gray] //tableau de stockage des pions bien placés et mal placés
    var userSecretCode:[Int]=[] // tableau de stockage temporaire du code saisi par l'utilisateur
    var maxNumberOfattempts: Int = 20 //nombre de tentative maximun
    var score = Score() //structure score
    var alertTitle: String {
        get{
            if(isSuccess){
                return "Gagne !! 🥳🤩😁"
            }
            return "Perdu !! 🤪🥺😡"
        }

    }
    var alertMessage:String {
        get {
            if(isSuccess){
                return "Vous avez gagné la partie 🥳"
            }
            return "Vous avez perdu la partie 😡"
        }
    }
    
    var isGameOver: Bool {
        get {
            return (counter == maxNumberOfattempts) || isSuccess
        }
    }
    
    var isSuccess: Bool{
        get{
            return self.wellPlaced == self.secretCodeLength
        }
    }
    
    /* Demarrer une partie de jeux */
    public func start(complexite: Level = .easy){
        switch complexite {
        case .easy:
            maxNumberOfattempts = 15
            break
        case .medium:
            maxNumberOfattempts = 12
            break
        case .hard:
            maxNumberOfattempts = 12
            secretCodeLength = 6
            break
        }
        counter = 0
        if !history.isEmpty{
            history.removeAll()
        }
        generateSecret(complexite: complexite);
    }
    
    /* la methode permet de génerer un code */
    private func generateSecret(complexite: Level = .easy){
        secretCode.removeAll()
        switch complexite {
        case .easy:
            while(secretCode.count<secretCodeLength){
                let digit = generateIdentifier();
                if !secretCode.contains(digit){
                    self.secretCode.append(digit)
                }
            }
            break
            
        default:
            for _ in 1 ... secretCodeLength {
                self.secretCode.append(generateIdentifier())
            }
            break
        }
        
        print("Nouveau code: \(secretCode)")
    }
    
    /* la methode permet de verifier le code saisi */
    public func checkValueEnteredByUser(userValue: [Int]) -> Bool{
        self.userSecretCode=userValue
        counter+=1
        resultPlaced.removeAll()
        var secret = self.secretCode
        self.wellPlaced=0
        self.wrongPlaced=0
        
        //recherche des pions bien placé
        for i in 0 ..< secretCodeLength
        {
            if(secret[i] == userValue[i] ){
                self.wellPlaced+=1
                resultPlaced.append(Color.green)
                secret[i] = -1
            }
        }
        
        //recherche des pions mal placé
        for i in 0 ..< secretCodeLength
        {
            if(secret.contains(userValue[i]) ){
                self.wrongPlaced+=1
                resultPlaced.append(Color.red)
                if let index = secret.firstIndex(of: userValue[i]) {
                    secret[index] = -1
                }
            }
        }
        
        resultPlaced.shuffle()
        secret.removeAll()
        history.append(Result(id: counter,resultPlaced: resultPlaced, userSecretCode: userValue))
        scoreManger()
        return isGameOver
    }
    
    /* generation d'un identifiant compris entre 1 et 6 */
    private func generateIdentifier() -> Int{
        return (Int(arc4random()) % self.numberOfFruits)+1
    }
    
    /* Gestion du score */
    public func scoreManger(){
        if(isGameOver){
            if(isSuccess){
                score.incrementScorePlayer()
            }else {
                score.incrementScoreSystem()
            }
        }
    }
    
    /* Detection des doublon dans les propositions de code du joueur*/
    public func isDuplicate(userValue: [Int])->Bool{
        
        for result in history {
            if(result.userSecretCode.elementsEqual(userValue)){
                return true
            }
        }
        
        return false
    }
}

