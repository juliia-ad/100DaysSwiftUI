//
//  HabitsView.swift
//  HabitTracker
//
//  Created by Júlia on 8/8/22.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject var habits: Habits
    @State var actualView: String
    @State var showingSheet = false
    
    var body: some View {
        List(actualView == "Daily" ? habits.daily : habits.generic) { habit in
            GeometryReader { geo in
                NavigationLink {
                    DetailHabitView(habits: habits, habit: habit)
                } label: {
                    HStack {
                        ZStack {
                            Circle()
                                .stroke(habit.counter == 0 ? Color.red : Color.green, lineWidth: 3)
                                .frame(width: geo.size.height, height: geo.size.height)
                            Text(String(habit.counter))
                        }
                        Text(habit.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle(actualView)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            AddHabit(habits: habits)
        }
    }
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView(habits: Habits(), actualView: "Daily")
    }
}
