//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Júlia on 16/8/22.
//

import CoreData
import SwiftUI

//Generic FilteredList

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWHIT %@", filterKey, filterValue))
        self.content = content
    }
    
    
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
            
        }
    }
        
        
        
        
    
}







/*
-- Filtered List specially for class Singer
 
struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    init(filter: String){
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
        /*
         by assigning to _fetchRequest, we aren’t trying to say “here’s a whole bunch of new results we want to you to use,” but instead we’re telling Swift we want to change the whole fetch request itself.
         */
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            
        }
    }
}
*/
