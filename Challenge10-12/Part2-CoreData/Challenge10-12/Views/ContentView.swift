//
//  ContentView.swift
//  Challenge10-12
//
//  Created by Júlia on 17/8/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])  var users: FetchedResults<CachedUser>
    
    @StateObject var usersArray = Users()   //Needed to call to download the JSON data
    
    var body: some View {
        NavigationView {
                List {
                    ForEach(users){ user in
                        NavigationLink {
                            DetailUserView(user: user, allUsers: usersArray)
                        } label: {
                            UserNameView(user: user)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)

                    }
            }
            .listStyle(.plain)
            .navigationTitle("Users")
            .padding(.top)
            .task {
                await usersArray.fetchUsers(moc: moc)
            }
            
        }
        
        
        
        
        /*NavigationView {
            List {
                ForEach(users.users) { user in
                    GeometryReader { proxy in
                        NavigationLink(destination: DetailUserView()) {
                            VStack(alignment: .leading, spacing: 40) {
                                Text(user.name)
                                HStack {
                                    Circle()
                                        .fill(user.isActive ? .green : .red)
                                        .frame(width: proxy.size.height/3, height: proxy.size.height/3)
                                    Text(user.isActive ? "Active now" : "Offline")
                                        .foregroundColor(.secondary)
                                }
                                .padding(10)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                
            }
            .environment(\.defaultMinListRowHeight, 80)
            .listStyle(.plain)
            .navigationTitle("Users")
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct UserNameView: View {
    let user: CachedUser
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Circle()
                    .fill(user.isActive ? .green : .gray)
                    .frame(width: 12)
                Text(user.wrappedName)
                    .bold()
                Spacer()
            }
            
            Text(user.isActive ? "Active now" : "")
                .foregroundColor(.gray)
                .font(.subheadline)
                .padding(.leading, 20)
        }
    }
    
}
