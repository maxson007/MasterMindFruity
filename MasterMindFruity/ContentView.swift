//
//  ContentView.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 18/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State var score = 0
    @State var gameIsInProgress=false
    @State var bestScore=0
    var body: some View {
        
        VStack {
            HStack {
                if score>bestScore && score != 0 {
                Image(systemName: "flame").foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)).multilineTextAlignment(.center).padding().font(Font.custom("Juicy Fruity", size: 20, relativeTo: .title)).animation(.easeIn(duration: 3))
                }
                Text("Score: \(score)").foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)).multilineTextAlignment(.center).padding().font(Font.custom("Juicy Fruity", size: 20, relativeTo: .title)).animation(.easeIn(duration: 3))
            }
            if gameIsInProgress {
                Image(systemName: "plus.square").foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)).multilineTextAlignment(.center).padding().font(Font.custom("Juicy Fruity", size: 33, relativeTo: .title)).animation(.easeIn(duration: 3)).onTapGesture {
                    
                    self.score+=1
                }
            }
            Spacer()
            if !gameIsInProgress{
                Button(action: {
                    self.score=0
                    gameIsInProgress=true
                    Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (Timer) in
                        gameIsInProgress = false
                        if score > bestScore {
                            bestScore=score
                        }
                    }
                }) {
                    Text("Nouvelle partie").foregroundColor(Color.green).multilineTextAlignment(.center).padding().font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title)).animation(.easeIn(duration: 3))
                }.padding()
            }
            /* Button(action: {
             
             }) {
             Text("MasterMind Fruity !").foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0)).multilineTextAlignment(.center).padding().font(Font.custom("Juicy Fruity", size: 33, relativeTo: .title)).animation(.easeIn(duration: 3))
             }*/
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
