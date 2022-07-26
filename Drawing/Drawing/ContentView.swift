//
//  ContentView.swift
//  Drawing
//
//  Created by Júlia on 2/8/22.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        NavigationView {
            Form {
                NavigationLink {
                    Flower()
                } label: {
                    Text("Introduction")
                }
                NavigationLink {
                    //
                } label: {
                    Text("ArrowChallenge")
                }
                NavigationLink {
                    //
                } label: {
                    Text("ColorCyclingRectangle Challenge")
                }
                
            }
            .navigationTitle("Drawings")
        }
        
        
        /*Path() { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            
        }
        .stroke(.blue, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
