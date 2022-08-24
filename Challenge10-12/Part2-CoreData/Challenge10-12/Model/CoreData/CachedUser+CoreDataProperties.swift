//
//  CachedUser+CoreDataProperties.swift
//  Challenge10-12
//
//  Created by Júlia on 23/8/22.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?
    
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedAge: Int {
        Int(age)
    }
    public var wrappedCompany: String {
        company ?? "Unknown company"
    }
    public var wrappedEmail: String {
        email ?? "Unknown email"
    }
    public var wrappedAddress: String {
        address ?? "Unknown address"
    }
    public var wrappedAbout: String {
        about ?? "-"
    }
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    public var wrappedTags: String {
        tags ?? ""
    }
    public var wrappedFriends: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    

}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
