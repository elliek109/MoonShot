//
//  ListView.swift
//  MoonShot
//
//  Created by Student on 11/11/25.
//

import SwiftUI

struct ListView: View {
    struct CrewMember: Identifiable {
        var id = UUID()
        let role: String
        let astronaut: Astronaut
    }
    let crew: [CrewMember]
    let mission: Mission
    let astronaut: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(crew) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 120, height: 84)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white,lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundStyle(.white)
                                Rectangle()
                                    .frame(height: 2)
                                    .foregroundStyle(.lightBackground)
                                    .padding(.vertical)
                            }
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
        .navigationTitle("Astronauts")
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.astronaut = astronauts
        
        self.crew = mission.crew.map { member in
            if astronauts[member.name] != nil {
                return CrewMember(role: member.role, astronaut: astronauts[member.name]!)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}



#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return ListView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

