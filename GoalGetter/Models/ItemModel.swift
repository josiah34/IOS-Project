//
//  ItemModel.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
// Josiah Galloway 101296257
import Foundation

// Define a struct named `ItemModel` that represents a single to-do list item.
struct ItemModel: Identifiable, Codable {
    // Use the `Identifiable` protocol to give each item a unique identifier.
    let id: String
    var title: String
    let isCompleted: Bool
    var priority: Priority
    
    // Define an initializer that allows you to create an item with a custom ID, title, priority, and completion status.
    init(id: String = UUID().uuidString, title: String, priority: Priority, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.priority = priority
        self.isCompleted = isCompleted
    }
    
    // This function returns a new `ItemModel` instance with the `isCompleted` property toggled.
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, priority: priority, isCompleted: !isCompleted)
    }
    
    // This function returns a new `ItemModel` instance with the `title` property updated to the specified value.
    func updateTitle(_ newTitle: String) -> ItemModel {
        return ItemModel(id: id, title: newTitle, priority: priority, isCompleted: isCompleted)
    }
    
    // This function returns a new `ItemModel` instance with the `priority` property updated to the specified value.
    func updatePriority(_ newPriority: Priority) -> ItemModel {
        return ItemModel(id: id, title: title, priority: newPriority, isCompleted: isCompleted)
    }
}

enum Priority: String, Codable, CaseIterable {
    case high
    case medium
    case low
}
