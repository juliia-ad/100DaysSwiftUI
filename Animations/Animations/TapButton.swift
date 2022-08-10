//
//  TapButton.swift
//  Animations
//
//  Created by Júlia on 20/7/22.
//

import SwiftUI

struct TapButton: View {
    @State var amountAnimation = 1.0
    
    var body: some View {
        Button("Tap me"){
            //amountAnimation = 2
        }
        .padding(50)
        .background(.red)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.black)
                .scaleEffect(amountAnimation)
                .animation(.easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: amountAnimation)
        )
        .onAppear {
            amountAnimation = 2
        }
    }
}

struct TapButton_Previews: PreviewProvider {
    static var previews: some View {
        TapButton()
    }
}
