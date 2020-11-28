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
        Home()
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
    @State var counter:Int = 0
    @State var isWinner:Bool = false
    @State var isActivateValidateButton: Bool = false
    var body: some View{
        
        VStack {
            List{
                ForEach(game.history) { value in
                    HStack{
                        Text("\(value.id)").foregroundColor(Color.blue).multilineTextAlignment(.center).font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title)).rotationEffect(.radians(.pi))
                            .scaleEffect(x: -1, y: 1, anchor: .center)
                        Divider()
                        ForEach(value.userSecretCode, id: \.self) { idFruit in
                            
                            HStack {
                                Image(basket.fruits[idFruit-1].name).resizable().aspectRatio(contentMode: .fit).rotationEffect(.radians(.pi))
                                    .scaleEffect(x: -1, y: 1, anchor: .center)
                            }
                            
                        }
                        Divider()
                        
                        VStack {
                            
                                HStack {
                                
                                    Circle()
                                        .fill(
                                            value.resultPlaced.indices.contains(0) ?  value.resultPlaced[0]
                                                : Color.gray
                                        )
                                        .frame(width: 30, height: 30)
                                    
                                    Circle()
                                        .fill(                                            value.resultPlaced.indices.contains(1) ?  value.resultPlaced[1]
                                                                                            : Color.gray)
                                        .frame(width: 30, height: 30)
                                    
                                }
                                
                                
                                HStack {
                                    
                                    Circle()
                                        .fill(                 value.resultPlaced.indices.contains(2) ?  value.resultPlaced[2]
                                                                                            : Color.gray)
                                        .frame(width: 30, height: 30)
                                    
                                    
                                    Circle()
                                        .fill(                                            value.resultPlaced.indices.contains(3) ?  value.resultPlaced[3]
                                                                                            : Color.gray)
                                        .frame(width: 30, height: 30)
                                    
                                }
                                
                            
                        }
                    }
                }
                
            }.rotationEffect(.radians(.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
            Spacer()
            Divider()
            HStack {
                ForEach(self.basket.fruits, id: \.id) { fruit in
                    FruitView(fruit: fruit,  selectedFruits: $userSelectedFruit).onTapGesture {
                        if userSelectedFruit.count<game.level{
                            userSelectedFruit.append(fruit.id)
                            fruit.isSelected=true
                        }
                        
                    }
                }
                
            }.padding(10)
            
            Button(action: {
                self.isActivateValidateButton=false
                isWinner = game.checkValueEnteredByUser(userValue: userSelectedFruit)
                
                clearButton()
                print(game.history)
                
            }) {
                Text("Valider !")
                    .font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title))
            }
            .disabled(!activateValidateButton())
            .opacity(activateValidateButton() ? 1 : 0.2)
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
        userSelectedFruit.removeAll()
    }
    private func activateValidateButton() ->Bool{
        return userSelectedFruit.count == game.level
    }
    
}


struct FruitView : View {
    @State var fruit: Fruit
    @Binding var selectedFruits:[Int]
    var body: some View{
        Image(fruit.name).resizable().aspectRatio(contentMode: .fit).opacity(fruit.isSelected ? 0.2: 1)
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

class Game: ObservableObject {
    @Published var history : [Result] = []
    var secretCode : [Int] = []
    let numberOfFruits=6;
    let level=4;
    var wellPlaced: Int = 0; //bien place
    var wrongPlace: Int = 0; //mal place
    var counter : Int = 0
    var resultPlaced: [Color]=[Color.gray,Color.gray,Color.gray,Color.gray]
    var userSecretCode:[Int]=[]
    public func generateSecret(){
        for _ in 1 ... level {
            self.secretCode.append(generateIdentifier())
        }
        if !history.isEmpty{
            history.removeAll()
        }
        print(secretCode)
    }
    
    public func checkValueEnteredByUser(userValue: [Int]) -> Bool{
        self.userSecretCode=userValue
        counter+=1
        resultPlaced.removeAll()
        var secret = self.secretCode
        self.wellPlaced=0
        self.wrongPlace=0
        for i in 0 ..< level
        {
            if(secret[i] == userValue[i] ){
                self.wellPlaced+=1
                resultPlaced.append(Color.green)
                secret[i] = -1
            }
        }
        
        for i in 0 ..< level
        {
            if(secret.contains(userValue[i]) ){
                self.wrongPlace+=1
                resultPlaced.append(Color.red)
                if let index = secret.firstIndex(of: userValue[i]) {
                    secret[index] = -1
                }
            }
        }
        resultPlaced.shuffle()
        secret.removeAll()
        print(userValue)
        history.append(Result(id: counter,resultPlaced: resultPlaced, userSecretCode: userValue))
        
        return isSuccess()
    }
    
    private func isSuccess() -> Bool{
        return self.wellPlaced == self.level
    }
    
    private func generateIdentifier() -> Int{
        return (Int(arc4random()) % self.numberOfFruits)+1
    }
}


class Result: Identifiable{
    var id : Int
    var resultPlaced : [Color]
    var userSecretCode: [Int]
    
    init(id : Int,resultPlaced : [Color],userSecretCode: [Int]) {
        self.id = id
        self.resultPlaced=resultPlaced
        self.userSecretCode=userSecretCode
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
