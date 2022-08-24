//
//  Users.swift
//  Challenge10-12
//
//  Created by Júlia on 17/8/22.
//

import Foundation
import CoreData

class Users: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case users
    }
    
    @Published var users = [User]()  //Empty array every time app launches.
    
    //We always want to initalize this class with the information on the url
    /*init() {
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching users: \(error?.localizedDescription ?? "Unknown")")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decoded = try decoder.decode([User].self, from: data)
                
                //Asynchornous
                DispatchQueue.main.async {
                    self.users = decoded.sorted(by: {
                        $0.name < $1.name
                    })
                }
                
            } catch let decodeError {
                print("Error decoding users: \(decodeError.localizedDescription)")
            }
        }
        task.resume() //!! Poner en marcha el dataTask creado anteriormente.
    }*/
    
    init() {}
    
    //Core data function: creates CachedUser from each User in users array
    func updateCache(moc: NSManagedObjectContext) {
        for user in users {
            let cachedUser = CachedUser(context: moc)
            
            cachedUser.id = user.id
            cachedUser.isActive = user.isActive
            cachedUser.name = user.name
            cachedUser.age = Int16(user.age)
            cachedUser.company = user.company
            cachedUser.email = user.email
            cachedUser.address = user.address
            cachedUser.about = user.about
            cachedUser.registered = user.registered
            cachedUser.tags = user.tags.joined(separator: ",")  //creates one string from the array
            
            for friend in user.friends {
                let cachedFriend = CachedFriend(context: moc)
                cachedFriend.id = friend.id
                cachedFriend.name = friend.name
                cachedUser.addToFriends(cachedFriend)   //Add the Friend to the User entity
            }
        }
        try? moc.save()
    }
    
    
    func fetchUsers(moc: NSManagedObjectContext) async {
        guard users.isEmpty else { return }  //Avoid downloading again if the users are already fetched.
        
        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            users = try decoder.decode([User].self, from: data)
            
            //To make sure our Core Data code never tries to overlap with SwiftUI’s code
            await MainActor.run(body: {
                updateCache(moc: moc)
            })
            
        } catch {
            print("Downloading failed")
        }
    }
    
    //Given a Friend instance, returns the same User
    func findUser(friendID: UUID) -> User {
        return users.first {
            $0.id == friendID
        }!
    }

        
    
    /*private func downloadData(_ request: URLRequest) async {
        
        //let (data, response, error) = try await URLSession.shared.dataTask(with: request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Download failed: \(error?.localizedDescription ?? "Unknown")")
                return
            }
            
            do {
                let decoded = try await JSONDecoder().decode([User].self, from: data)
                self.users = decoded
            
            } catch let decodingError {
                print("Failed: \(decodingError.localizedDescription)")
            }
            
        }
    }*/
    
                                    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        users = try container.decode([User].self, forKey: .users)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(users, forKey: .users)
    }
    
    
    
    
    
}
