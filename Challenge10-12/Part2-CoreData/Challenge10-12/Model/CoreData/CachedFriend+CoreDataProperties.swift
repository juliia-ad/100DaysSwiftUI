//
//  CachedFriend+CoreDataProperties.swift
//  Challenge10-12
//
//  Created by Júlia on 23/8/22.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?
    
    public var wrappedName: String {
        name ?? ""
    }
    

}

extension CachedFriend : Identifiable {

}
