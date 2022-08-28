//
//  Location.swift
//  Bucketlist
//
//  Created by Júlia on 28/8/22.
//

import Foundation
import CoreLocation


//Equatable to be able to find a particular location from an array of locations.
struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double    //Latitude and longitude separately instead of CLLLocationCoordinate => directly Codable conformance
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    //When making the struct equatable, Swift will write this function for us by comparing every property against every other property.
    //Nevertheless, we just need to compare the id, so we can save work.
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longitude: -0.141)
}
