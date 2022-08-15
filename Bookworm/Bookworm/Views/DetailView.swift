//
//  DetailView.swift
//  Bookworm
//
//  Created by Júlia on 14/8/22.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAlert = false
    
    let book: Book
    
    var body: some View {
        VStack {
            ZStack {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    //.offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating))) //We don't want to be able to change from this view the rating => we make it constant
                .font(.largeTitle)
            
            Spacer()
            
            HStack {
                if let date = book.date {
                    Text("Reviewed on: ")
                    Text(date, style: .date)
                }
            }
            
        }
        .navigationTitle(book.title ?? "Unknown")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .cancel(Text("Cancel")), secondaryButton: .destructive(Text("Delete"), action: deleteBook))
        }
        .toolbar {
            Button {
                showingAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }

        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        
        dismiss()
    }
    
}
