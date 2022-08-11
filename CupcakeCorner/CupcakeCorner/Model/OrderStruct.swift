//
//  OrderStruct.swift
//  CupcakeCorner
//
//  Created by Júlia on 11/8/22.
//

import Foundation

//Challenge 3: convert the Order class in a class with just one struct

class OrderStructClass: ObservableObject, Codable {
    enum StructCodingKeys: CodingKey {
        case order
    }
    
    @Published var order: Order
    
    init(order: Order){
        self.order = order
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StructCodingKeys.self)
        try container.encode(order, forKey: .order)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StructCodingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }
}



struct Order: Codable {
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Pistacho"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
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
}

