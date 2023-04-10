    //
    //  ItemModel.swift
    //  GoalGetter
    //
    //  Created by mac on 2023-03-22.
    // Josiah Galloway 101296257
    import Foundation

    // Define a struct named `ItemModel` that represents a single to-do list item.
struct ItemModel: Identifiable, Codable {
    let id: String
    var title: String
    let isCompleted: Bool
    var priority: Priority
    var dueDate: Date?
    
    init(id: String = UUID().uuidString, title: String, priority: Priority, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.priority = priority
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        ItemModel(id: self.id, title: self.title, priority: self.priority, isCompleted: !self.isCompleted, dueDate: self.dueDate)
    }
    
    func updateTitle(_ title: String) -> ItemModel {
        ItemModel(id: self.id, title: title, priority: self.priority, isCompleted: self.isCompleted, dueDate: self.dueDate)
    }
    
    func updatePriority(_ priority: Priority) -> ItemModel {
        ItemModel(id: self.id, title: self.title, priority: priority, isCompleted: self.isCompleted, dueDate: self.dueDate)
    }
    
    func updateDueDate(_ newDueDate: Date) -> ItemModel {
            return ItemModel(
                id: self.id,
                title: self.title,
                priority: self.priority,
                dueDate: newDueDate,
                isCompleted: self.isCompleted
            )
        }
}

enum Priority: String, Codable, CaseIterable {
    case high
    case medium
    case low
}

