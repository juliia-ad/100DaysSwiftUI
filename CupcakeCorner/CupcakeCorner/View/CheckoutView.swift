//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Júlia on 10/8/22.
//

import SwiftUI

enum AlertType {
    case confirmation, error
}

struct CheckoutView: View {
    //@ObservedObject var order: Order
    @ObservedObject var order: OrderStructClass
    
    //Alert + challenge 2
    @State private var confirmationMessage = ""
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State private var alertType: AlertType = .confirmation
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)
                
                Text("Your total is: \(order.order.cost, format: .currency(code: "EUR"))")
                    .font(.title)
                
                Button("Place Order"){
                    Task {
                        await placeOrder()
                    }
                }
                .padding()


            }
        }
        .navigationTitle("Check out")
        .alert(isPresented: $showingAlert) {
            switch alertType {
            case .confirmation:
                return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            case .error:
                return Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        /*.alert("Thank you!", isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }*/
        


    }
    
    
    func placeOrder() async {
        //We encode the order data
        guard let encoded = try? JSONEncoder().encode(order) else {
            //print("Failed to encode order")
            showErrorAlert(error: "Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!    //force unwrapping bc we now it won't fail in this case
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        
        do {
            //(data, _) is a map. Data contains the result of the upload to internet
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            showConfirmationAlert(confirmation: "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!")
            
        } catch {
            print("Checkout failed")
            showErrorAlert(error: "Checkout failed")
        }
        
        
    }
    
    func showConfirmationAlert(confirmation: String) {
        alertType = .confirmation
        confirmationMessage = confirmation
        showingAlert = true
    }
    
    func showErrorAlert(error: String) {
        alertType = .error
        errorMessage = error
        showingAlert = true
    }
    
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderStructClass(order: Order()))
    }
}
