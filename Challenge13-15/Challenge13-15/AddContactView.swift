//
//  AddContactView.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = ViewModel()
    
    var onSave: (Contact) -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.secondary.opacity(0.6))
                    .frame(width: 200, height: 200)
                
                Text("Tap to upload picture")
                
                vm.image?
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    
            }
            .onTapGesture {
                vm.showingImagePicker = true
            }
            .padding(.bottom)
            
            Divider()
            
            Section {
                TextField("First Name", text: $vm.firstName)
                TextField("Second Name", text: $vm.secondName)
            }
            .padding(.vertical, 5)
            
            Spacer()
            
            Button("Save") {
                //Save contact + image
                let newContact = vm.createContact()
                onSave(newContact)
                dismiss()
            }.disabled(vm.firstName.isEmpty || vm.image == nil)
            
        }
        .padding()
        .sheet(isPresented: $vm.showingImagePicker) {
            ImagePicker(image: $vm.UIimage)
        }
        .onChange(of: vm.UIimage) { newValue in
            if let UIimage = vm.UIimage {
                vm.image = Image(uiImage: UIimage)
            }
        }
    }
}

/*struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView()
    }
}*/
