//
//  LetterAnimations.swift
//  Animations
//
//  Created by Júlia on 22/7/22.
//

import SwiftUI

struct LetterAnimations: View {
    let letters = Array("Hello world")
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { index in
                Text(String(letters[index]))
                    .foregroundColor(enabled ? .red : .blue)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(index)/20), value: dragAmount)
                
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ dragAmount = $0.translation })
                .onEnded({ _ in
                    dragAmount = .zero
                    enabled.toggle()
                })
        )
    }
}

struct LetterAnimations_Previews: PreviewProvider {
    static var previews: some View {
        LetterAnimations()
    }
}
