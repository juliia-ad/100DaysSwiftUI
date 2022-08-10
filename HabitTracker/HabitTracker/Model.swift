//
//  Model.swift
//  HabitTracker
//
//  Created by Júlia on 7/8/22.
//

import Foundation

struct Habit: Identifiable {
    var id = UUID()
    
    var title: String
    var description: String
    //var date: Date      //Date when the user started the habit.
    var counter: Int    //Times the user completed the habit
    var type: TypeHabit
}

class Habits: ObservableObject {
    @Published var daily: [Habit] = [habit1, habit2]
    @Published var generic: [Habit] = []
    
    func updateHabit(habit: Habit) {
        guard let index = getIndex(habit: habit) else { return }
        
        if (habit.type == .Daily) {
            daily[index] = habit
        } else {
            generic[index] = habit
        }
    }
    
    
    private func getIndex(habit: Habit) -> Int? {
        if (habit.type == .Daily) { return daily.firstIndex(where: { $0.id == habit.id }) }
        else { return generic.firstIndex(where: { $0.id == habit.id }) }
    }
    
    
}

enum TypeHabit: String {
    case Daily, Generic
}


//Pruebas
let habit1 = Habit(title: "Gym", description: "1h of gym", counter: 1, type: .Daily)
let habit2 = Habit(title: "Read", description: "1h of gym", counter: 0, type: .Daily)

