//
//  DetailUserView.swift
//  Challenge10-12
//
//  Created by Júlia on 20/8/22.
//

import SwiftUI

struct DetailUserView: View {
    @State var user: User
    var allUsers: Users
    
    
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Age: ")
                        .bold()
                    Text("\(String(user.age)) years")
                }
                HStack {
                    Image(systemName: "house.fill")
                    Text(String(user.address))
                }
                HStack {
                    Image(systemName: "briefcase.fill")
                    Text(String(user.company))
                }
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(String(user.email))
                }
            } header: {
                Text("Contact")
            }
            
        
            Section {
                Text(user.about)
            } header: {
                Text("About")
            }
            Section {
                Text(user.registered.formatted(date: .long, time: .shortened))
            } header: {
                Text("Registred")
            }
            
            Section {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(user.tags, id: \.self) { tag in
                        Text(tag)
                    }
                }
            } header: {
                Text("TAGS")
            }
            
            
            Section {
                ForEach(user.sortedFriends()) { friend in
                    let friendUser = allUsers.findUser(friendID: friend.id)
                    NavigationLink {
                        DetailUserView(user: friendUser, allUsers: allUsers)
                    } label: {
                        UserNameView(user: friendUser)
                    }
                }
            } header: {
                Text("FRIENDS")
            }

        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }

}

struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView(user: sampleUser, allUsers: Users())
    }
}
