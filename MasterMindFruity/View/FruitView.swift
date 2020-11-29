//
//  FruitView.swift
//  MasterMindFruity
//
//  Created by Aymane DANIEL on 29/11/2020.
//

import SwiftUI

struct FruitView : View {
    @State var fruit: Fruit
    @Binding var selectedFruits:[Int]
    var body: some View{
        Image(fruit.name).resizable().aspectRatio(contentMode: .fit).opacity(fruit.isSelected ? 0.2: 1).disabled(fruit.isSelected)
    }
}
