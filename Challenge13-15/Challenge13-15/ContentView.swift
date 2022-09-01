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
                    ForEach(vm.contacts) { contact in
                        NavigationLink {
                            ImageView(image: vm.getImage(imagePath: contact.profilePicture))
                        } label: {
                            HStack {
                                vm.getImage(imagePath: contact.profilePicture)?
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 100)
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
            .navigationTitle("Meeting contacts")
            .toolbar {
                ToolbarItem {
                    Button {
                        vm.showingAddContact = true
                    } label: {
                        Image(systemName: "plus")
                    }
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
