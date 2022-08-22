//
//  User.swift
//  Challenge10-12
//
//  Created by Júlia on 17/8/22.
//

import Foundation


struct User: Identifiable, Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    
    func sortedFriends() -> [Friend] {
        friends.sorted {
            $0.name < $1.name
        }
    }
    
}

var sampleUser: User {
    User(id: "123", isActive: true, name: "Nicole", age: 52, company: "Example", email: "Example", address: "Example", about: "About", registered: Date.now, tags: ["Cats", "Dogs"], friends: [Friend(id: "id", name: "name"), Friend(id: "id2", name: "name")])
}
