//
//  EditView-ViewModel.swift
//  Bucketlist
//
//  Created by Júlia on 29/8/22.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        var location: Location
        
        //Variables to change while editing the TextField
        @Published var name: String
        @Published var description: String
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            name = location.name
            description = location.description
            
            
        }
        
        func createNewLocation() -> Location {
            var newLocation = location  //Copy of the existing location
            newLocation.id = UUID()    //We need to change the id, so the MapAnnotation will notify the changes
            newLocation.name = name
            newLocation.description = description
            return newLocation
        }
        
        
        
        func fetchNearbyPlaces() async {
            //Wikipedia url
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                //Dictionnary: [Key: value] -> .values return array of all the values.
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
        
        
    }
}
