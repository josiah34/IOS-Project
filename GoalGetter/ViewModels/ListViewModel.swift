//
//  ListViewModel.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
//  Josiah Galloway 101296257

import Foundation
import SwiftUI
// Define a class named `ListViewModel` that manages the to-do list.
class ListViewModel: ObservableObject{
    
    // Use `@Published` to make the `items` property observable and automatically update any views that depend on it.
    @Published var items : [ItemModel] = [] {
        // Use `didSet` to save the items to user defaults whenever they change.
        didSet{
            saveItems()
        }
    }
    
    // Define a key to use when saving and loading items from user defaults.
    let itemsKey: String = "items_list"
    
    // Define an initializer that loads items from user defaults when the class is initialized.
    init(){
        getItems()
    }
    
    // This function loads items from user defaults.
    func getItems(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {return}
        
        self.items = savedItems
    }
    
    // This function deletes an item from the list.
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    // This function moves an item from one index to another in the list.
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, priority: Priority, dueDate: Date? = nil) {
        let newItem = ItemModel(title: title, priority: priority, isCompleted: false, dueDate: dueDate)
        items.append(newItem)
    }

    // This function updates the completion status and due date of an item in the list.
    func updateItem(item: ItemModel, dueDate: Date?) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            var updatedItem = item
            updatedItem.dueDate = dueDate
            items[index] = updatedItem
        }
    }
    
    // This function saves items to user defaults.
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey )
        }
    }
    func sortItemsByPriority() {
        items.sort { priorityValue(for: $0) < priorityValue(for: $1) }
    }

    private func priorityValue(for item: ItemModel) -> Int {
        switch item.priority {
        case .high:
            return 0
        case .medium:
            return 1
        case .low:
            return 2
        }
    }
    // This function returns a color based on the given priority.
    func getPriorityColor(priority: Priority) -> Color {
        switch priority {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .green
        }
    }

    // This function returns the next priority level after the given one.
    func getNextPriority(currentPriority: Priority) -> Priority {
        switch currentPriority {
        case .high:
            return .medium
        case .medium:
            return .low
        case .low:
            return .high
        }
    }
        
}
