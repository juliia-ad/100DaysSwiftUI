//
//  AddItemView.swift
//  ExpensesApp
//
//  Created by Júlia on 18/7/22.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State var nameItem: String = ""
    @State var typeItem: String = "Personal"
    @State var amountItem: String = ""
    
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $nameItem)
                Picker("Type", selection: $typeItem){
                    ForEach(expenses.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amountItem)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new item")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Save") {
                        let newItem = Item(name: nameItem, type: typeItem, amount: Double(amountItem)!)
                        expenses.items.append(newItem)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
            
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(expenses: Expenses())
    }
}
