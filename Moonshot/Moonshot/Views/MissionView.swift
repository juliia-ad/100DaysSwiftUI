//
//  MissionView.swift
//  Moonshot
//
//  Created by Júlia on 24/7/22.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                    
                    Text(mission.dateString)
                        .font(.subheadline.bold())
                        .foregroundColor(.secondary)
                        .padding(.top, 5)
                    
                    VStack(alignment: .leading) {
                        
                        customDivier()
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        customDivier()
                        
                        Text("Crew")
                            .font(.title.bold())
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                
                //Crew List
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.astronaut.id){ crewMember in
                            NavigationLink {
                                AstronautView(astronaut: crewMember.astronaut)
                            } label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 105)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().strokeBorder(.white, lineWidth: 1))
                                    
                                    
                                    VStack {
                                        Text(crewMember.astronaut.name)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.horizontal)
                            }

                        }
                    }
                }
            }
        }
        .navigationTitle(mission.textName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        
        //nombre de los astronautas de mission es la key del diccionario de astronautas
        self.crew = mission.crew.map({ member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        })
    }
    
}

struct MissionView_Previews: PreviewProvider {
    //We get all the missions from the bundle and we load the first one.
    static let missions: [Mission] = Bundle.main.decode("missions.txt")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.txt")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}

struct customDivier: View {
    
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.top)
    }
    
}

