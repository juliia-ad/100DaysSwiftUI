//
//  ContentView.swift
//  ExpensesApp
//
//  Created by Júlia on 18/7/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddItemView = false
    @State private var currentType = "Personal"
    var angle: Double {
        return showingAddItemView ? 90.0 : 0.0
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items.filter({ item in
                    item.type == currentType
                })) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "EUR"))
                            .foregroundColor(priceColor(item.amount))
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(item.name), \(item.amount.formatted(.currency(code: "EUR")))")
                    .accessibilityHint(item.type)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("ExpensesApp")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            showingAddItemView = true
                        }
                    } label: {
                        Image(systemName: "plus")
                            .rotationEffect(.degrees(angle))
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        currentType = "Personal"
                    } label: {
                        Image(systemName: "person")
                    }
                    .padding(30)
                    Button {
                        currentType = "Business"
                    } label: {
                        Image(systemName: "briefcase")
                    }
                    .padding(30)
                    Button {
                        currentType = "Family"
                    } label: {
                        Image(systemName: "house")
                    }
                    .padding(30)
                    Spacer()
                    
                }
                
            }
        }
        .sheet(isPresented: $showingAddItemView) {
            AddItemView(expenses: expenses)
        }
    }
    
    //Function that deletes an item from the expenses.
    func removeItems(at offset: IndexSet){
        //obtenemos todos los id de los items del mismo type que se encuentran en ese offset.
        let itemId = offset.map {
            expenses.items.filter { i in
                i.type == currentType
            }[$0].id
        }
        
        expenses.items.removeAll {
            $0.id == itemId[0]
        }
    }
    
    func priceColor(_ amount: Double) -> Color {
        switch amount {
        case 10.0..<100:
            return .orange
        case 100..<Double.infinity:
            return .red
        default:
            return .green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
