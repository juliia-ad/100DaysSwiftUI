//
//  Challenge10_12App.swift
//  Challenge10-12
//
//  Created by Júlia on 17/8/22.
//

import SwiftUI

@main
struct Challenge10_12App: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
