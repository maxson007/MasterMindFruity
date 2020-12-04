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
    var secretCode: [Int]
    var basket: FruitBasket = FruitBasket()
    var onPressNewParty: () -> Void = { }
    var body: some View {
        
            VStack {
                Text(title)
                    .font(Font.custom("Juicy Fruity", size: 30, relativeTo: .title))
                    .foregroundColor(Color(#colorLiteral(red: 0.6950075626, green: 0.8562402129, blue: 0.008320940658, alpha: 1))).padding()
                Text(message).font(.largeTitle).fontWeight(.semibold).foregroundColor(Color(#colorLiteral(red: 0.2365519702, green: 0.7098777294, blue: 0.2898065746, alpha: 1))).multilineTextAlignment(.center).padding()
                Text("Le code secret etait :").font(.title3).fontWeight(.semibold).multilineTextAlignment(.center)
                HStack {
                    
                    ForEach(secretCode, id: \.self) { idFruit in
                        HStack {
                            Image(basket.fruits[idFruit-1].name).resizable().aspectRatio(contentMode: .fit).frame(width: 53.0)
                        }
                        
                    }
                }
                Spacer()
                HStack(spacing: 20) {
                    Button(action:  {
                        self.isGameOver.toggle()
                        self.onPressNewParty()
                    }){
                        Text("Nouvelle partie").font(Font.custom("Juicy Fruity", size: 16, relativeTo: .title)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).padding()
                    }
                    .foregroundColor(.white)
                    .background(Color(#colorLiteral(red: 0.6950075626, green: 0.8562402129, blue: 0.008320940658, alpha: 1)))
                    .cornerRadius(25.0)
                }
            }
            .padding()
            .frame(width: screenSize.width * 0.99, height: screenSize.height * 0.6)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .offset(y: isGameOver ? 0 : screenSize.height)
            .animation(.spring())
        }
        
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(title: "Gagne !!", message: "Vous avez gagné la partie 🥳", isGameOver: .constant(true),secretCode: [1,6,3,4])
    }
}
