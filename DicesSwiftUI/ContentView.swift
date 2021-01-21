//
//  ContentView.swift
//  DicesSwiftUI
//
//  Created by Emelie on 2021-01-21.
//

import SwiftUI

struct ContentView: View {
    @State var diceNumber1 = 3
    @State var diceNumber2 = 5
    @State var sum = 0
    @State var showBustSheet = false
    
    var body: some View {
        ZStack {
            Color(red: 11.0/256, green: 96.0/256, blue: 60.0/256)
                .ignoresSafeArea()
            
            VStack {
                Text("\(sum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                HStack {
                    DiceView(n: diceNumber1)
                    DiceView(n: diceNumber2)
                }.onAppear() {
                    roll()
                }
                
                Spacer()
                
                Button(action: {
                    roll()
                }) {
                    Text("Roll")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
                .cornerRadius(20.0)
                Spacer()
            }
        }
        .sheet(isPresented: $showBustSheet, onDismiss: { self.sum = 0 }) {
            BustSheet(sum: sum)
        }
    }
    
    func roll() {
        diceNumber1 = Int.random(in: 1...6)
        diceNumber2 = Int.random(in: 1...6)
        sum += diceNumber1 + diceNumber2
//        if sum > 21 {
//            showBustSheet = true
//        }
        showBustSheet = sum > 21
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //BustSheet(sum: 55)
    }
}

struct BustSheet: View {
    let sum: Int
    
    var body: some View {
        ZStack {
            Color(red: 11.0/256, green: 96.0/256, blue: 60.0/256)
                .ignoresSafeArea()
            VStack {
                Text("Bust")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .padding()
                Text("\(sum)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.red)
                    .padding()
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct DiceView: View {
    let n: Int
    
    var body: some View {
        Image(systemName: "die.face.\(n)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
