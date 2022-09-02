//
//  VM-ContentView.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import Foundation
import SwiftUI
import MapKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var contacts: [Contact]
        @Published var showingAddContact = false
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("Contacts")
        
        
        
        //We load contacts from the file fileManager. If not, we use empty array.
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                contacts = try JSONDecoder().decode([Contact].self, from: data)
            } catch {
                contacts = [Contact]()
            }
        }
        
        func addContact(contact: Contact) {
            contacts.append(contact)
            saveContacts()
        }
        
        func saveContacts() {
            do {
                let data = try JSONEncoder().encode(contacts)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func getImage(imagePath: String?) -> Image? {
            if let imageData = FileManager.getImage(imagePath: imagePath) {
                if let UIimage = UIImage(data: imageData){
                    return Image(uiImage: UIimage)
                }
            }
            
            return nil
        }
        
        func deleteContact(at offset: Int){
            contacts.remove(at: offset)
        }
        
        func getCoordinate(contact: Contact) -> CLLocationCoordinate2D{
            CLLocationCoordinate2D(latitude: contact.latitude, longitude: contact.longitude)
        }
        
        func makeMapRegion(contact: Contact) -> MKCoordinateRegion {
            let coordinate = getCoordinate(contact: contact)
            return MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        }
        
        func sortedContacts() -> [Contact] {
            return contacts.sorted {
                if $0.firstName == $1.firstName {
                    return $0.secondName < $1.secondName
                } else {
                    return $0.firstName < $1.firstName
                }
            }
        }
        
        
    }
}
