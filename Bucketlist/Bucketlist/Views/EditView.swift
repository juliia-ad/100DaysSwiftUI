//
//  EditView.swift
//  Bucketlist
//
//  Created by Júlia on 28/8/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var vm: ViewModel
    var onSave: (Location) -> Void
    

    /*
     @ESCAPING EXPLANATION
        @escaping means the closure will be called later, not in the function that is called (in this case, the init)
        Avisa a Swift que debe guardar la closure en memoria para ser usada más tarde
     */
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _vm = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
        
        /*
        CODE BEFORE CREATING VIEW MODEL
        self.location = location
        self.onSave = onSave
        
        /*
         UNDERSCORE ANNOTATION:
         Used because we want to CREATE and initalize the property wrapper.
            name: refers to the value inside the property wrapper
            _name: refers to the property wrapper
         */
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
         */
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $vm.name)
                    TextField("Description", text: $vm.description)
                }
                
                Section("Nearby...") {
                    switch vm.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(vm.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        let newLocation = vm.createNewLocation()
                        onSave(newLocation)
                        dismiss()
                    }
                }
            }
            .task { //trigger the function as soon as the view appears.
                await vm.fetchNearbyPlaces()
            }
        }
    }
    
}

/*struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example)
    }
}
*/
