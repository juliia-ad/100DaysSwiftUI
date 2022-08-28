//
//  EditView.swift
//  Bucketlist
//
//  Created by Júlia on 28/8/22.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    
    //Variables to change while editing the TextField
    @State private var name: String
    @State private var description: String
    
    /*
     @ESCAPING EXPLANATION
        @escaping means the closure will be called later, not in the function that is called (in this case, the init)
        Avisa a Swift que debe guardar la closure en memoria para ser usada más tarde
     */
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        /*
         UNDERSCORE ANNOTATION:
            name: refers to the value inside the property wrapper
            _name: refers to the property wrapper
         */
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        var newLocation = location  //Copy of the existing location
                        newLocation.id = UUID()    //We need to change the id, so the MapAnnotation will notify the changes
                        newLocation.name = name
                        newLocation.description = description
                        
                        onSave(newLocation)
                        dismiss()
                    }
                }
            }
        }
    }
    
    
    var onSave: (Location) -> Void
}

/*struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example)
    }
}
*/
