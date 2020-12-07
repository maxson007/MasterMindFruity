//
//  GameView.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import SwiftUI
import AudioToolbox
import AVFoundation

struct GameView : View{
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var game = Game()
    
    @ObservedObject var basket: FruitBasket = FruitBasket()
    
    @State var userSelectedFruit:[Int]=[]
    @State var isGameOver:Bool = false
    @State var userSelectedFruitIsDuplicate: Bool = false
    let systemSoundIDFruitTap: SystemSoundID = 1104
    let systemSoundIDButtonTap: SystemSoundID = 1105
    
    
    var body: some View{
        if !isGameOver{
            /* Score et le buton exit*/
            VStack {
                HStack {
                    Text("Player: \(game.score.player) vs System: \(game.score.system) ").foregroundColor(.green).padding()
                    Spacer()
                    
                    Text("Exit▶︎").font(Font.custom("Juicy Fruity", size: 12, relativeTo: .title)).foregroundColor(.green).padding().onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                /* Affichage de la selection de fruit en live */
                HStack {
                    ForEach(userSelectedFruit, id: \.self) { idFruit in
                        Image(basket.fruits[idFruit-1].name).resizable().aspectRatio(contentMode: .fit).frame(width: 25.0)
                    }
                }.animation(.easeOut)
                Spacer()
                /* History de proposotion */
                ScrollView(.vertical) {
                    ScrollViewReader { scrollView in
                        LazyVStack {
                            ForEach(game.history) { value in
                                
                                ZStack {
                                    ResultRowView(result: value, basket: basket).id(game.history.count+1)
                                    
                                }
                                Divider()
                            }
                        }.onChange(of: game.history, perform: { value in
                            withAnimation(.spring()){
                                scrollView.scrollTo(game.history.count)
                            }
                            
                        })
                    }
                }.rotationEffect(.radians(.pi))
                .scaleEffect(x: -1, y: 1, anchor: .bottom)
                Spacer()
                /* Panier de fruit à selectionner */
                Divider()
                HStack {
                    ForEach(self.basket.fruits, id: \.id) { fruit in
                        FruitView(fruit: fruit,  selectedFruits: $userSelectedFruit).onTapGesture {
                            selectFruitToggle(fruit: fruit)
                            AudioServicesPlaySystemSound(systemSoundIDFruitTap)
                        }
                    }
                    
                }.padding(10)
                /* Bouton de validation de la proposion*/
                Button(action: {
                    userSelectedFruitIsDuplicate=game.isDuplicate(userValue: userSelectedFruit)
                    if !userSelectedFruitIsDuplicate{
                        isGameOver = game.checkValueEnteredByUser(userValue: userSelectedFruit)
                    }
                    clearButton()
                    AudioServicesPlaySystemSound(systemSoundIDButtonTap)
                }) {
                    Text("Valider !")
                        .font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title))
                }.buttonStyle(ValiderButtonStyle())
                .disabled(!activateValidateButton())
                .opacity(activateValidateButton() ? 1 : 0.5)
                
                
            }.navigationBarBackButtonHidden(true).onAppear(
                perform: {self.game.start()}
            ).alert(isPresented: $userSelectedFruitIsDuplicate, content: {
                        /* Alert doublon*/
                        Alert(title: Text("👮🏾‍♀️ Attention !!! 🤪"),
                              message: Text("Vous avez déjà composé cette combinaison")
                        )})
        }else{
            /* View Game Over*/
            GameOverView(title: game.alertTitle, message: game.alertMessage, isGameOver: $isGameOver, secretCode: game.secretCode, isPlayerSuccess: game.isSuccess, onPressNewParty: {
                print("press nouvelle partie")
                game.start()
                
            })
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
    
    /* Selection de fruit */
    private func selectFruitToggle(fruit: Fruit){
        
        if !fruit.isSelected {
            userSelectedFruit.append(fruit.id)
            fruit.isSelected=true
        }else{
            userSelectedFruit.removeAll(where: {
                $0 == fruit.id
            })
            fruit.isSelected=false
        }
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
