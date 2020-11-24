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
    @State var basket = [
        Fruit(name: "citron-jaune", identifier: 1, isSelected: false ),
        Fruit(name: "fraise", identifier: 2,isSelected: false),
        Fruit(name: "orange", identifier: 3, isSelected: false),
        Fruit(name: "poire", identifier: 3, isSelected: false),
        Fruit(name: "pomme-rouge", identifier: 4, isSelected: false),
        Fruit(name: "pomme-vert", identifier: 5,isSelected: false),
    ]
    
    @State var userSelectedFruit:[Int]=[]
    @State var isWinner:Bool = false
    var body: some View{
        
        VStack {
            Spacer()
            HStack {
                
                ForEach(basket, id: \.id) { fruit in
                    FruitView(fruit: fruit,  selectedFruits: $userSelectedFruit)
                }
                
            }.padding(10)
            
            Button(action: {
                print(userSelectedFruit)
                isWinner = game.checkValueEnteredByUser(userValue: userSelectedFruit)
                print(game.history)

            }) {
                Text("Valider !")
                    .font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title))
            }
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 0.69500756259999996, green: 0.85624021289999996, blue: 0.0083209406580000006, opacity: 1.0))
            .cornerRadius(25.0).padding(.bottom, 10)
            
        }.navigationBarBackButtonHidden(false).onAppear(
            perform: {self.game.generateSecret()}
        )
    }
    
}


struct FruitView : View {
    @State var fruit: Fruit
    @State var isSelected: Bool = false
    @Binding var selectedFruits:[Int]
    var body: some View{
        Image(fruit.name).resizable().aspectRatio(contentMode: .fit).opacity(fruit.isSelected ? 0.2: 1).onTapGesture {
            self.fruit.isSelected=true
            if(fruit.isSelected){
                self.selectedFruits.append(self.fruit.identifier)
            }
        }
    }
}


struct Fruit: Identifiable {
    var id = UUID()
    var name: String
    var identifier:Int
    var isSelected: Bool
}

struct BasketFruits {
    var fruits : [Fruit] = []
    var selectedFruit: [Int] = []
}

struct Game {
    var history : [Array<Int>] = []
    var secretCode : [Int] = []
    let numberOfFruits=6;
    let level=4;
    var wellPlaced: Int = 0; //bien place
    var wrongPlace: Int = 0; //mal place
    public mutating func generateSecret(){
        for _ in 1 ... level {
            self.secretCode.append(generateIdentifier())
        }
        print(secretCode)
    }
    public mutating func checkValueEnteredByUser(userValue: [Int]) -> Bool{
        history.append(userValue)
        var secret = self.secretCode
        for i in 0 ... level-1
        {
            if(secret[i] == userValue[i] ){
                self.wellPlaced+=1
                secret[i] = -1
            }
        }
        
        for i in 0 ... level-1
        {
            if(secret.contains(userValue[i]) ){
                self.wrongPlace+=1
                if let index = secret.firstIndex(of: userValue[i]) {
                    secret[index] = -1
                }
            }
        }
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
