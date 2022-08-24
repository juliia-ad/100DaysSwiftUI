//
//  ContentView.swift
//  Challenge10-12
//
//  Created by Júlia on 17/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var users = Users()
    
    
    var body: some View {
        NavigationView {
                List {
                    ForEach(users.users){ user in
                        NavigationLink {
                            DetailUserView(user: user, allUsers: users)
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
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Circle()
                    .fill(user.isActive ? .green : .gray)
                    .frame(width: 12)
                Text(user.name)
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
