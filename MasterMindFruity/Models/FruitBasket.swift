//
//  FruitBasket.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import Foundation

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
