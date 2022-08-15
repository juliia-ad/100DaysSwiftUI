//
//  ContentView.swift
//  Bookworm
//
//  Created by Júlia on 12/8/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title), SortDescriptor(\.author)]) var books: FetchedResults<Book>  //fetch request that reads all the books we have
    
    @State private var showingAddBookView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                            
                            VStack(alignment: .leading){
                                Text(book.title ?? "Unknow title")
                                    .font(.headline)
                                    .foregroundColor(book.rating == Int16(1) ? .red : .white)
                                Text(book.author ?? "Unknow author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
                
                
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddBookView.toggle()
                    } label: {
                        Label("Add book", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
            }
        }
        .sheet(isPresented: $showingAddBookView) {
            AddBookView()
        }
        .preferredColorScheme(.dark)
    }
    
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save() //we save the context of the persistent data
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
