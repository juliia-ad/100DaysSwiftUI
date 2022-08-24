//
//  DetailUserView.swift
//  Challenge10-12
//
//  Created by Júlia on 20/8/22.
//

import SwiftUI

struct DetailUserView: View {
    @Environment(\.managedObjectContext) var moc
    @State var user: CachedUser
    var allUsers: Users
    
    
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Age: ")
                        .bold()
                    Text("\(String(user.wrappedAge)) years")
                }
                HStack {
                    Image(systemName: "house.fill")
                    Text(String(user.wrappedAddress))
                }
                HStack {
                    Image(systemName: "briefcase.fill")
                    Text(String(user.wrappedCompany))
                }
                HStack {
                    Image(systemName: "envelope.fill")
                    Text(String(user.wrappedEmail))
                }
            } header: {
                Text("Contact")
            }
            
        
            Section {
                Text(user.wrappedAbout)
            } header: {
                Text("About")
            }
            Section {
                Text(user.wrappedRegistered.formatted(date: .long, time: .shortened))
            } header: {
                Text("Registred")
            }
            
            Section {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(user.wrappedTags.components(separatedBy: ","), id: \.self) { tag in
                        Text(tag)
                    }
                }
            } header: {
                Text("TAGS")
            }
            
            
            Section {
                ForEach(user.wrappedFriends) { friend in
                    Text(friend.wrappedName)
                }
            } header: {
                Text("FRIENDS")
            }

        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }

}

/*struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView(user: sampleUser, allUsers: Users())
    }
}
*/
