//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Júlia on 15/8/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    //@FetchRequest(sortDescriptors: []) private var wizards: FetchedResults<Wizard>
    
    //@FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) private var ships: FetchedResults<Ship>
    
    @State private var lastNameFilter = "A"

    var body: some View {
        
        CandyView()
        
        
        /*VStack {
            
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            //FilteredList(filter: lastNameFilter)
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A"){
                lastNameFilter = "A"
            }
            Button("Show S"){
                lastNameFilter = "S"
            }
        }*/
        
        
        
        
        
        
        //SHIP VIEW
        /*VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown ship")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Ship 1"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Ship 2"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Ship 3"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Ship 4"
                ship4.universe = "Star Wars"
                
                try? moc.save()

            }
        }*/
        
        
        
        
        /*VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            } label: {
                Text("Add")
            }
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }

        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
