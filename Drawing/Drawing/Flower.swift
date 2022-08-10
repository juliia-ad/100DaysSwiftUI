//
//  Flower.swift
//  Drawing
//
//  Created by Júlia on 5/8/22.
//

import SwiftUI

struct FlowerShape: Shape {
    var petalOffset: Double
    var petalWidth: Double
    
    func path(in rect: CGRect) -> Path {
        var path =  Path()
        
        //creamos petalo a partir de un nuevo path
        let originalPath = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width/2))

        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 4) {
            
            //rotación para el nuevo petalo
            let rotation = CGAffineTransform(rotationAngle: number)
            
            //transformacion para colocar en el centro de la pantalla
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            

            //aplicamos transformaciones al nuevo petalo
            let rotatedPetal = originalPath.applying(position)
            
            //añadimos petalo a la flor existente
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct Flower: View {
    @State private var petalOffset: Double = -40.0
    @State private var petalWidth: Double = 100
    
    var body: some View {
        VStack {
            FlowerShape(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding([.horizontal, .bottom])
            
        }
    }
}

struct Flower_Previews: PreviewProvider {
    static var previews: some View {
        Flower()
    }
}
