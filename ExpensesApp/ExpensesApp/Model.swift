//
//  Model.swift
//  ExpensesApp
//
//  Created by Júlia on 18/7/22.
//

import Foundation

struct Item: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}


class Expenses: ObservableObject {
    let types = ["Personal", "Business", "Family"]
    
    @Published var items = [Item]() {
        didSet {
            if let encodedData = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encodedData, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){    //savedItems has the data encoded
            if let decodedData = try? JSONDecoder().decode([Item].self, from: savedItems){  //we decode the savedItems
                items = decodedData
                return
            }
        }
        items = []
    }
    
}
