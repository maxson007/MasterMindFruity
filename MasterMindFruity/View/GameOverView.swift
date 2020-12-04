//
//  FruityAlert.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 04/12/2020.
//

import SwiftUI

struct GameOverView: View {
    let screenSize = UIScreen.main.bounds
    var title: String
    var message: String
    @Binding var isGameOver: Bool
    var secretCode: [Int]=[1,2,3,4]
    var basket: FruitBasket = FruitBasket()
    var body: some View {
        
        ZStack {
            //Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                Text(title)
                    .font(Font.custom("Juicy Fruity", size: 16, relativeTo: .title))
                    .foregroundColor(Color(#colorLiteral(red: 0.6950075626, green: 0.8562402129, blue: 0.008320940658, alpha: 1))).padding()
                Text(message)
                ForEach(secretCode, id: \.self) { idFruit in
                    HStack {
                        Image(basket.fruits[idFruit-1].name).resizable().aspectRatio(contentMode: .fit).rotationEffect(.radians(.pi))
                            .scaleEffect(x: -1, y: 1, anchor: .center)
                    }
                    
                }
                Spacer()
                HStack(spacing: 20) {
                    Button(action:  {
                        self.isGameOver.toggle()
                    }){
                        Text("Nouvelle partie").font(Font.custom("Juicy Fruity", size: 16, relativeTo: .title)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).padding()
                    }
                    .foregroundColor(.white)
                    .background(Color(#colorLiteral(red: 0.6950075626, green: 0.8562402129, blue: 0.008320940658, alpha: 1)))
                    .cornerRadius(25.0).padding(.bottom, 10)
                }
            }
            .padding()
            .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .offset(y: isGameOver ? 0 : screenSize.height)
            .animation(.spring())
        }
        
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(title: "MasterMind Fruity", message: "Hello message", isGameOver: .constant(true),secretCode: [1,2,3,4])
    }
}
