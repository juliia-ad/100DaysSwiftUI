//
//  AddBookView.swift
//  Bookworm
//
//  Created by Júlia on 12/8/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc    //variable donde se encuentran los tipos de datos creados a partir del modelo de datos
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    /*Picker("Rating", selection: $rating) {
                        ForEach(0..<6) {
                            Text(String($0))
                        }
                    }*/
                } header: {
                    Text("Write a review")
                }

                Section {
                    HStack {
                        Spacer()
                        Button("Save") {
                            let newBook = Book(context: moc)
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author == "" ? "Unknown Author" : author
                            newBook.rating = Int16(rating)
                            newBook.genre = genre
                            newBook.review = review
                            newBook.date = Date.now
                            
                            try? moc.save() //save into persistent data
                            dismiss()
                        }
                        Spacer()
                    }
                }
                .disabled(title == "")  //If the book doesn't have a title, we can't save it
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
