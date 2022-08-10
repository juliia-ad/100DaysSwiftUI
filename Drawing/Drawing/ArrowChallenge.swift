//
//  ArrowChallenge.swift
//  Drawing
//
//  Created by Júlia on 5/8/22.
//

import SwiftUI


struct Arrow: Shape {
    @State var thickness: Double
    @State var triangleBase: Double = 300
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //rectangle
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addRect(CGRect(x: rect.midX-(thickness/2), y: rect.maxY, width: thickness, height: rect.minY-rect.maxY))
        
        
        //triangle
        
        
        
        return path
    }
}

struct ArrowChallenge: View {
    @State private var lineWidth: Double = 10
    
    var body: some View {
        Arrow(thickness: lineWidth)
            .frame(width: 300, height: 300)
    }
}

struct ArrowChallenge_Previews: PreviewProvider {
    static var previews: some View {
        ArrowChallenge()
    }
}
