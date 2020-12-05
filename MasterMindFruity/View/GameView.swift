//
//  GameView.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import SwiftUI


struct GameView : View{
    @Environment(\.presentationMode) var presentationMode
    
    @State var game = Game()
    
    @ObservedObject var basket: FruitBasket = FruitBasket()
    
    @State var userSelectedFruit:[Int]=[]
    @State var isGameOver:Bool = false
    
    var body: some View{
        if !isGameOver{
            VStack {
                HStack {
                    Text("Player: \(game.score.player) vs System: \(game.score.system) ").foregroundColor(.green).padding()
                    Spacer()
                    
                    Text("Exit").font(Font.custom("Juicy Fruity", size: 12, relativeTo: .title)).foregroundColor(.green).padding().onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                List{
                    ForEach(game.history) { value in
                        ResultRowView(result: value, basket: basket)
                    }
                    
                }.rotationEffect(.radians(.pi))
                .scaleEffect(x: -1, y: 1, anchor: .center)
                Spacer()
                Divider()
                HStack {
                    ForEach(self.basket.fruits, id: \.id) { fruit in
                        FruitView(fruit: fruit,  selectedFruits: $userSelectedFruit).onTapGesture {
                            if userSelectedFruit.count<game.secretCodeLength{
                                if !fruit.isSelected {
                                    userSelectedFruit.append(fruit.id)
                                    fruit.isSelected=true
                                }
                            }
                            
                        }
                    }
                    
                }.padding(10)
                
                Button(action: {
                    isGameOver = game.checkValueEnteredByUser(userValue: userSelectedFruit)
                    clearButton()
                }) {
                    Text("Valider !")
                        .font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title))
                }.buttonStyle(ValiderButtonStyle())
                .disabled(!activateValidateButton())
                .opacity(activateValidateButton() ? 1 : 0.5)
                
                
            }.navigationBarBackButtonHidden(true).onAppear(
                perform: {self.game.start()}
            )
        }else{
            GameOverView(title: game.alertTitle, message: game.alertMessage, isGameOver: $isGameOver, secretCode: game.secretCode){
                print("press nouvelle partie")
                game.start()
            }
        }
    }
    
    /* Reinitialiation du des fruits (bouttons) */
    private  func clearButton(){
        for i in 0 ..< basket.fruits.count{
            self.basket.fruits[i].isSelected=false
        }
        userSelectedFruit.removeAll()
    }
    /* verification si on active le button valider*/
    private func activateValidateButton() ->Bool{
        return userSelectedFruit.count == game.secretCodeLength
    }
    
}

/* Style du button valider */
struct ValiderButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(Color(#colorLiteral(red: 0.2365519702, green: 0.7098777294, blue: 0.2898065746, alpha: 1)))
            .cornerRadius(25.0).padding(.bottom, 10)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
