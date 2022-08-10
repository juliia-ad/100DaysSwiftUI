//
//  GridView.swift
//  Moonshot
//
//  Created by Júlia on 25/7/22.
//

import SwiftUI

struct GridView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.textName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.dateString)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .padding(.top)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                        
                        
                    }
                }
                .padding([.horizontal, .bottom])
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.txt")
    static let missions: [Mission] = Bundle.main.decode("missions.txt")
    
    
    static var previews: some View {
        GridView(astronauts: astronauts, missions: missions)
    }
}
