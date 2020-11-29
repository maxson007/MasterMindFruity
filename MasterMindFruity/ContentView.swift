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
        GameView()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
