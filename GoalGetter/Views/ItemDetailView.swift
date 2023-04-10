//
//  ItemDetailView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-28.
//
import SwiftUI

struct ItemDetailView: View {
    let item: ItemModel
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var title: String
    @State private var priority: Priority
    
    init(item: ItemModel) {
        self.item = item
        
        // Initialize the state variables with the values from the item
        _title = State(initialValue: item.title)
        _priority = State(initialValue: item.priority)
    }
    
    var body: some View {
        VStack {
            // Text field for editing the title
            TextField("Title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Picker for selecting the priority
            Picker("Priority", selection: $priority) {
                Text("High").tag(Priority.high)
                Text("Medium").tag(Priority.medium)
                Text("Low").tag(Priority.low)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Save button
            Button("Save") {
                let updatedItem = item.updateTitle(title).updatePriority(priority)
                listViewModel.updateItem(item: updatedItem)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Edit Item")
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var item = ItemModel(title: "Test Item", priority: .high, isCompleted: false)
    
    static var previews: some View {
        NavigationView {
            ItemDetailView(item: item)
                .environmentObject(ListViewModel())
        }
    }
}
