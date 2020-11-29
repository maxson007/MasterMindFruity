//
//  HomeView.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import SwiftUI



struct HomeView : View{
    var body: some View {
        
        NavigationView{
            VStack {
                Image("fraise-man").resizable().frame(width: 630/6, height: 459/6, alignment: .center)
                
                Image("MasterMind Fruity !!").resizable().frame(width: 958/4, height: 306/4, alignment: .center)
                HStack {
                    Image("Poire-serena").resizable().frame(width: 157/5, height: 362/5, alignment: .center)
                    Image("orange-1").resizable().frame(width: 144/5, height: 273/5, alignment: .center)
                    Image("fraise-1").resizable().frame(width: 252/5, height: 386/5, alignment: .center)
                    Image("Poire-serena-jaune").resizable().frame(width: 166/5, height: 336/5, alignment: .center)
                }
                Spacer()
                NavigationLink(destination: GameView()){
                    VStack {
                        Image(systemName: "play.circle").multilineTextAlignment(.center).font(Font.custom("Juicy Fruity", size: 50, relativeTo: .title)).foregroundColor(.blue)
                        Text("Start").foregroundColor(Color.blue).multilineTextAlignment(.center).font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title)).padding(.bottom, 20)
                    }
                    
                }
                
                
            }
        }
        
        
    }
}

