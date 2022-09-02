//
//  Contact.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import Foundation
import PhotosUI
import MapKit


struct Contact: Identifiable, Codable {
    var id: UUID
    var firstName: String
    var secondName: String
    var profilePicture: String?  //url of the path from the documents directory
    
    var locationRecorded = false
    
    var longitude: Double = 0
    var latitude: Double = 0
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(firstName: String, secondName: String, profilePicture: String?, location: CLLocationCoordinate2D?) {
        id = UUID()
        self.firstName = firstName
        self.secondName = secondName
        self.profilePicture = profilePicture
        if let location = location {
            locationRecorded = true
            longitude = location.longitude
            latitude = location.latitude
        }
    }
}
