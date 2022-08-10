//
//  ListView.swift
//  Moonshot
//
//  Created by Júlia on 25/7/22.
//

import SwiftUI

struct ListView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    
    
    var body: some View {

            List(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack(spacing: 13) {
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 70)
                            .padding(5)
                        
                        VStack(spacing: 10) {
                            Text(mission.textName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.dateString)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    
                        /*.padding(.vertical)
                         .frame(maxWidth: .infinity)
                         .background(.lightBackground)
                         */
                    }
                }
                .listStyle(.plain)
                .listRowBackground(Rectangle().foregroundColor(.lightBackground))
                
            }
            .background(.darkBackground)
            
           /* .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }*/
    }
}
            

struct ListView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.txt")
    static let missions: [Mission] = Bundle.main.decode("missions.txt")
    
    
    static var previews: some View {
        ListView(astronauts: astronauts, missions: missions)
    }
}
