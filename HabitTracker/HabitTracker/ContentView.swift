//
//  ContentView.swift
//  HabitTracker
//
//  Created by Júlia on 7/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    
    @State private var actualView = "Daily"
    
    
    var body: some View {
        NavigationView {
            Group {
                if (actualView == "Daily"){
                    HabitsView(habits: habits, actualView: actualView)
                } else {
                    HabitsView(habits: habits, actualView: actualView)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button {
                        actualView = "Daily"
                    } label: {
                        Text("DAILY")
                    }
                    .padding(70)
                    Button {
                        actualView = "Generic"
                    } label: {
                        Text("GENERIC")
                    }
                    .padding(70)
                    Spacer()
                }
            }
        }
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
