//
//  DataController.swift
//  Bookworm
//
//  Created by Júlia on 12/8/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {  //error is not nil
                print("Core data failed to load: \(error.localizedDescription)")
            }
            
            
            //We ask CoreData to merge duplicate objects in a certain way (in this case, overwrites the old using properties from the new object)
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump        }
    }
    
    
}
