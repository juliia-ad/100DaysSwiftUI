//
//  ContentView.swift
//  Moonshot
//
//  Created by Júlia on 23/7/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.txt")
    let missions: [Mission] = Bundle.main.decode("missions.txt")
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    @State private var gridLayout = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.darkBackground.edgesIgnoringSafeArea(.all)
                if (gridLayout){
                    GridView(astronauts: astronauts, missions: missions)
                } else {
                    ListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        gridLayout.toggle()
                    } label: {
                        Image(systemName: "eye")
                            .foregroundColor(.white)
                    }
                    
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



