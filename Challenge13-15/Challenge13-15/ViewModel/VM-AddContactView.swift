//
//  VM-AddContactView.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import Foundation
import SwiftUI
import UIKit
import MapKit

extension AddContactView {
    @MainActor class ViewModel: ObservableObject {
        @Published var showingImagePicker = false
        
        @Published var firstName = ""
        @Published var secondName = ""
        
        @Published var image: Image?
        @Published var UIimage: UIImage?
        
        let locationFetcher = LocationFetcher()
        
        
        func createContact() -> Contact {
            if let UIimage = UIimage {
                if let jpegData = UIimage.jpegData(compressionQuality: 0.8) {
                    let imagePath = FileManager.saveImage(image: jpegData)!
                    return Contact(firstName: firstName, secondName: secondName, profilePicture: imagePath, location: getLocation()) //We save in the contact the image path, not the image
                }
            }
            
            return Contact(firstName: firstName, secondName: secondName, profilePicture: nil, location: getLocation())
        }
        
        
        func getLocation() -> CLLocationCoordinate2D? {
            if let location = locationFetcher.lastKnownLocation {
                return location
            }
            return nil
        }
        
    }
}
