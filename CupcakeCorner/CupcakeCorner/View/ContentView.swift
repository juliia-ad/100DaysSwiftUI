//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Júlia on 10/8/22.
//

import SwiftUI

struct ContentView: View {
    //@StateObject var order = OrderClass()
    @StateObject var order = OrderStructClass(order: Order())
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cupcake type", selection: $order.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cupcakes: \(order.order.quantity)", value: $order.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.order.specialRequestEnabled.animation())
                    
                    if (order.order.specialRequestEnabled) {
                        Toggle("Add extra frosting", isOn: $order.order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }

                }
            }
        }
        .navigationTitle("Cupcake corner")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
