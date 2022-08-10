//
//  DetailHabitView.swift
//  HabitTracker
//
//  Created by Júlia on 7/8/22.
//

import SwiftUI

struct DetailHabitView: View {
    @ObservedObject var habits: Habits
    @State var habit: Habit
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                TextField("Habit Title", text: $habit.title)
                TextField("Description", text: $habit.description)
                Stepper("Counter: \(habit.counter)") {
                    habit.counter += 1
                    habits.updateHabit(habit: habit)
                } onDecrement: {
                    if (habit.counter > 0) {
                        habit.counter -= 1
                        habits.updateHabit(habit: habit)
                    }
                }
            }
        }
        .navigationTitle("Edit Habit")
    }
}

struct DetailHabitView_Previews: PreviewProvider {
    static var previews: some View {
        //DetailHabitView(habit: habit1)
        Text("hi")
    }
}
