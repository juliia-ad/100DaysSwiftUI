//
//  ContentView.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(vm.sortedContacts()) { contact in
                        NavigationLink {
                            ImageView(image: vm.getImage(imagePath: contact.profilePicture), mapRegion: vm.makeMapRegion(contact: contact), contact: contact)
                        } label: {
                            HStack(spacing: 20) {
                                vm.getImage(imagePath: contact.profilePicture)?
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .frame(width: 70, height: 70)
                                Text(contact.firstName + " " + contact.secondName)
                            }
                        }
                    }
                    .onDelete { offsets in
                        for offset in offsets {
                            vm.deleteContact(at: Int(offset))
                        }
                    }
                }
                .listStyle(.plain)
                
            }
            .padding(.top)
            .navigationTitle("Meeting contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        vm.showingAddContact = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $vm.showingAddContact) {
                AddContactView { newContact in
                    vm.addContact(contact: newContact)
                }
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
