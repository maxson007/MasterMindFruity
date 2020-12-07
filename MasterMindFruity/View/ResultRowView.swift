//
//  ResultRowView.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import SwiftUI

/* Cette classe permet l'affichage d'une ligne dans la liste de proposition */
struct ResultRowView: View {
    var result: Result
    var basket: FruitBasket
    var body: some View {
        HStack{
            Text("\(result.id)").foregroundColor(Color.blue).multilineTextAlignment(.center).font(Font.custom("Juicy Fruity", size: 15, relativeTo: .title)).rotationEffect(.radians(.pi))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            Divider()
            ForEach(result.userSecretCode, id: \.self) { idFruit in
                HStack {
                    Image(basket.fruits[idFruit-1].name).resizable().aspectRatio(contentMode: .fit).rotationEffect(.radians(.pi))
                        .scaleEffect(x: -1, y: 1, anchor: .center).frame(width: 55)
                }
                
            }
            Divider()
            VStack {
                HStack {
                    Circle()
                        .fill(result.resultPlaced.indices.contains(0) ?  result.resultPlaced[0] : Color.gray)
                        .frame(width: 30, height: 30)
                    
                    Circle()
                        .fill(result.resultPlaced.indices.contains(1) ?  result.resultPlaced[1] : Color.gray)
                        .frame(width: 30, height: 30)
                    
                }
                
                HStack {
                    Circle()
                        .fill(result.resultPlaced.indices.contains(2) ?  result.resultPlaced[2] : Color.gray)
                        .frame(width: 30, height: 30)
                    
                    
                    Circle()
                        .fill(result.resultPlaced.indices.contains(3) ?  result.resultPlaced[3] : Color.gray)
                        .frame(width: 30, height: 30)
                    
                }
                
            }
        }.padding().animation(.spring())
    }
}

