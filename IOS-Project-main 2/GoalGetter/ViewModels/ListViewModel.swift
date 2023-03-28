//
//  ListViewModel.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
//  Josiah Galloway 101296257

import Foundation

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
    
    // This function adds an item to the list.
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    // This function updates the completion status of an item in the list.
    func updateItem(item: ItemModel){
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    // This function saves items to user defaults.
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey )
        }
    }
        
}
