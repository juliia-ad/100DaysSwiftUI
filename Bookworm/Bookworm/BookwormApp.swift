//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Júlia on 12/8/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
