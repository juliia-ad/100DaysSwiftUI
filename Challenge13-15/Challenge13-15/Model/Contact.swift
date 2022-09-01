//
//  Contact.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import Foundation
import PhotosUI


struct Contact: Identifiable, Codable {
    var id: UUID
    var firstName: String
    var secondName: String
    var profilePicture: String?  //url of the path from the documents directory
    
    init(firstName: String, secondName: String, profilePicture: String?) {
        id = UUID()
        self.firstName = firstName
        self.secondName = secondName
        self.profilePicture = profilePicture
    }
}
