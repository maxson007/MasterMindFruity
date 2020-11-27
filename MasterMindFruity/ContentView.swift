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


struct Home : View{
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

struct GameView : View{
    
    @State var game = Game()

    @ObservedObject var basket: FruitBasket = FruitBasket()
    
    @State var userSelectedFruit:[Int]=[]
    @State var isWinner:Bool = false
    @State var isActivateValidateButton: Bool = false
    var body: some View{
        
        VStack {
            List(game.history, id: \.self){ value in
                
                ForEach(value,id: \.self) { item in
                    
                    HStack {
                        Image(basket.fruits[item].name).resizable().aspectRatio(contentMode: .fit).rotationEffect(.radians(.pi))
                            .scaleEffect(x: -1, y: 1, anchor: .center)
                    }
                    
                }
                Divider()
                
                VStack {
                    HStack {
                        
                        ForEach(game.resultPlaced, id: \.self) { result in
                            Circle()
                                .fill(Color.green)
                                .frame(width: 30, height: 30)
                        }
                    }
                    
                    HStack {
                        ForEach(0..<game.wrongPlace) { item in
                            Circle()
                                .fill(Color.red)
                                .frame(width: 30, height: 30)
                        }.padding()
                    }
                    
                }
                
                
            }.rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
            Spacer()
            Divider()
            HStack {
                ForEach(self.basket.fruits, id: \.id) { fruit in
                    FruitView(fruit: fruit,  selectedFruits: $userSelectedFruit)
                }
                
            }.padding(10)
            
            Button(action: {
                self.isActivateValidateButton=false
                isWinner = game.checkValueEnteredByUser(userValue: userSelectedFruit)
                userSelectedFruit.removeAll()
                clearButton()
                print(game.history)
                
            }) {
                Text("Valider !")
                    .font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title))
            }
            .disabled(!activateValidateButton())
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 0.69500756259999996, green: 0.85624021289999996, blue: 0.0083209406580000006, opacity: 1.0))
            .cornerRadius(25.0).padding(.bottom, 10)
            
        }.navigationBarBackButtonHidden(false).onAppear(
            perform: {self.game.generateSecret()}
        )
    }
    
    private  func clearButton(){
        for i in 0 ..< basket.fruits.count{
            self.basket.fruits[i].isSelected=false
        }
    }
    private func activateValidateButton() ->Bool{
        return userSelectedFruit.count == game.level
    }
    
}


struct FruitView : View {
    @State var fruit: Fruit
   // @State var isSelected: Bool = false
    @Binding var selectedFruits:[Int]
    var body: some View{
        Image(fruit.name).resizable().aspectRatio(contentMode: .fit).opacity(fruit.isSelected ? 0.2: 1).onTapGesture {
            self.fruit.isSelected=true
            if(fruit.isSelected){
                self.selectedFruits.append(self.fruit.id)
            }
        }.disabled(selectedFruits.count>=4)
    }
}


class Fruit: Identifiable ,ObservableObject{
    var id : Int
    var name: String
    @Published var isSelected: Bool
    
    init(id: Int ,name: String,isSelected: Bool){
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}

class FruitBasket: ObservableObject{
    @Published var fruits: [Fruit]

    init(){
        self.fruits = [
            Fruit(id: 1, name: "citron-jaune", isSelected: false ),
            Fruit(id: 2, name: "fraise",isSelected: false),
            Fruit(id: 3, name: "orange", isSelected: false),
            Fruit(id: 4, name: "poire", isSelected: false),
            Fruit(id: 5, name: "pomme-rouge", isSelected: false),
            Fruit(id: 6, name: "pomme-vert",isSelected: false),
            ]
    }

}

struct Game {
    var history : [[Int]] = []
    var secretCode : [Int] = []
    let numberOfFruits=6;
    let level=4;
    var wellPlaced: Int = 0; //bien place
    var wrongPlace: Int = 0; //mal place
    var resultPlaced: [Int]=[]
    public mutating func generateSecret(){
        for _ in 1 ... level {
            self.secretCode.append(generateIdentifier())
        }
        if !history.isEmpty{
            history.removeAll()
            
        }
        //history.append([1,2,3,5])
        print(secretCode)
    }
    public mutating func checkValueEnteredByUser(userValue: [Int]) -> Bool{
        history.append(userValue)
        resultPlaced.removeAll()
        var secret = self.secretCode
        for i in 0 ... level-1
        {
            if(secret[i] == userValue[i] ){
                self.wellPlaced+=1
                resultPlaced.append(1)
                secret[i] = -1
            }
        }
        
        for i in 0 ... level-1
        {
            if(secret.contains(userValue[i]) ){
                self.wrongPlace+=1
                resultPlaced.append(0)
                if let index = secret.firstIndex(of: userValue[i]) {
                    secret[index] = -1
                }
            }
        }
        resultPlaced.shuffle()
        secret.removeAll()
        return isSuccess()
    }
    
    private func isSuccess() -> Bool{
        return self.wellPlaced == self.level
    }
    
    private func generateIdentifier() -> Int{
        return (Int(arc4random()) % self.numberOfFruits)+1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
