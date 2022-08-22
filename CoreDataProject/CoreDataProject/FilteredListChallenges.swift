//
//  FilteredListChallenges.swift
//  CoreDataProject
//
//  Created by Júlia on 17/8/22.
//

import CoreData
import SwiftUI


struct FilteredListChallenges<T: NSManagedObject, Content: View>: View {
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

struct FilteredListChallenges_Previews: PreviewProvider {
    static var previews: some View {
        FilteredListChallenges()
    }
}
