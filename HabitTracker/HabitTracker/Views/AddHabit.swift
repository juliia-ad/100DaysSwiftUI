//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Júlia on 8/8/22.
//

import SwiftUI

struct AddHabit: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var habits: Habits
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var type: TypeHabit = .Daily
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                Picker("Type", selection: $type) {
                    Text("Daily").tag(TypeHabit.Daily)
                    Text("Generic").tag(TypeHabit.Generic)
                }
            }
            .navigationTitle("Create New Habit")
            .toolbar {
                ToolbarItem(placement: .bottomBar){
                    Button {
                        if (type == .Daily) {
                            habits.daily.append(Habit(title: title, description: description, counter: 0, type: type))
                        } else {
                            habits.generic.append(Habit(title: title, description: description, counter: 0, type: type))
                        }
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
