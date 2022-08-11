//
//  Order.swift
//  CupcakeCorner
//
//  Created by Júlia on 10/8/22.
//

import SwiftUI

class OrderClass: ObservableObject, Codable {
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Pistacho"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        if (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty) {
            return false
        }
        
        //Challenge 1
        if (name.isAllWhitespaces || streetAddress.isAllWhitespaces || city.isAllWhitespaces || zip.isAllWhitespaces) {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        //$2 per cupcake
        var cost = Double(quantity)*2
        
        //$1/cupcake with extra frosting
        if extraFrosting { cost += Double(quantity) }
        
        //$0.5/cupcake with sprinkles
        if addSprinkles { cost += 0.5 * Double(quantity) }
        
        return cost
        
    }
    
    
    //Encoding
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
        
    }
    
    
    //We must provide an initializer that doesn't need a decoder to create an instance, for the
    //objects that don't come from encoded data.
    init() { }
    
    
    
}


extension String {
    
    var isAllWhitespaces: Bool {
        if self.isEmpty { return false }
        
        let array = Array(self)
        
        /*ForEach(array, id: \.self) { c in
            if (c != " ") { return false }
        }*/
        
        for i in 0..<array.count {
            if (array[i] != " ") { return false }
        }
        
        return true
    }
}
