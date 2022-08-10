//
//  AstronautView.swift
//  Moonshot
//
//  Created by Júlia on 25/7/22.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding(.horizontal)
            }
        }
        .navigationTitle(astronaut.name)
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.txt")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
        //Optional bc map keys may or may not return any value.
    }
}
