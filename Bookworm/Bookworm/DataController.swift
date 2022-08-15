//
//  DataController.swift
//  Bookworm
//
//  Created by Júlia on 12/8/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {  //error is not nil
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    
}
