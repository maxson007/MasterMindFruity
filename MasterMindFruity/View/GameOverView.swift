//
//  FruityAlert.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 04/12/2020.
//

import SwiftUI
/* La vue qui affiche le resultat de la partie gagné ou perdu*/
struct GameOverView: View {
    let screenSize = UIScreen.main.bounds
    var title: String
    var message: String
    @Binding var isGameOver: Bool
    var secretCode: [Int]
    var basket: FruitBasket = FruitBasket()
    var isPlayerSuccess: Bool
    var onPressNewParty: () -> Void = { }
    var audioPlayer = SoundPlayer()
    var body: some View {
        
            VStack {
                Text(title)
                    .font(Font.custom("Juicy Fruity", size: 30, relativeTo: .title))
                    .foregroundColor(isPlayerSuccess ? Color(#colorLiteral(red: 0.6950075626, green: 0.8562402129, blue: 0.008320940658, alpha: 1)) : Color(#colorLiteral(red: 0.9593037963, green: 0.05458746105, blue: 0.004058180377, alpha: 1))).padding()
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .fixedSize(horizontal: false, vertical: true)
                Text(message).font(.largeTitle).fontWeight(.semibold).foregroundColor(isPlayerSuccess ? Color(#colorLiteral(red: 0.2365519702, green: 0.7098777294, blue: 0.2898065746, alpha: 1)) : Color(#colorLiteral(red: 0.9593037963, green: 0.05458746105, blue: 0.004058180377, alpha: 1))).multilineTextAlignment(.center).padding()
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .fixedSize(horizontal: false, vertical: true)
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
                    .background(isPlayerSuccess ? Color(#colorLiteral(red: 0.6950075626, green: 0.8562402129, blue: 0.008320940658, alpha: 1)) : Color(#colorLiteral(red: 0.9725183845, green: 0.5766973495, blue: 0.1202104464, alpha: 1)))
                    .cornerRadius(25.0)
                }
            }
            .padding()
            .frame(width: screenSize.width * 0.99, height: screenSize.height * 0.7)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .offset(y: isGameOver ? 0 : screenSize.height)
            .animation(.spring()).onAppear(perform: {
                audioPlayer.play(soundFile: isPlayerSuccess ? "Ta Da-SoundBible.com-1884170640" : "TunePocket-Access-Denied-Error-Buzz-Preview", type: "mp3")
            })
        }
        
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(title: "Gagne !!", message: "Vous avez gagné la partie 🥳", isGameOver: .constant(true),secretCode: [1,6,3,4], isPlayerSuccess: false)
    }
}
