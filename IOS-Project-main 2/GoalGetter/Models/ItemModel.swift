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
    let title: String
    let isCompleted: Bool
    
    // Define an initializer that allows you to create an item with a custom ID, title, and completion status.
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    // This function returns a new `ItemModel` instance with the `isCompleted` property toggled.
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
