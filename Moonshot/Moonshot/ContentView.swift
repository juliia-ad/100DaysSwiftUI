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
    
    var body: some View {
        Text("\(missions.count)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
