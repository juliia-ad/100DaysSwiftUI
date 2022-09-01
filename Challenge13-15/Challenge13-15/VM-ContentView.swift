//
//  VM-ContentView.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import Foundation
import SwiftUI

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
        
        
    }
}
