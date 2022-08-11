//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Júlia on 10/8/22.
//

import SwiftUI

struct AddressView: View {
    //@ObservedObject var order: Order
    @ObservedObject var order: OrderStructClass
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                TextField("Street Address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }

            }
            .disabled(order.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderStructClass(order: Order()))
    }
}
