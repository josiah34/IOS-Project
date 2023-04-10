//
//  ListRowView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
// Josiah Galloway 101296257
//Umit Kilinc - 101232721
// Define a SwiftUI view named `ListRowView` that displays a single row of a list.
import SwiftUI

// Define a SwiftUI view named `ListRowView` that displays a single row of a list.
struct ListRowView: View {
    // `item` is an instance of the `ItemModel` struct that this row will display.
    let item: ItemModel
    
    // The `ListViewModel` that manages the to-do list.
    @ObservedObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            // Add a tap gesture to cycle through different priority levels.
            // Use a transparent button to allow tapping on the entire row.
            Button(action: {
                let newPriority = listViewModel.getNextPriority(currentPriority: item.priority)
                let updatedItem = item.updatePriority(newPriority, dueDate: <#Date?#>)
                listViewModel.updateItem(item: updatedItem, dueDate: <#Date?#>)
            }, label: {
                HStack{
                    // Display an image that shows a checkmark or an empty circle depending on whether the item is completed.
                    Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                        // Make the checkmark green and the empty circle red.
                        .foregroundColor(item.isCompleted ? .green : .red)
                    // Display the title of the item.
                    Text(item.title)
                    // Add a spacer to push the title to the left and the checkmark to the right.
                    Spacer()
                    // Display the priority of the item as text.
                    Text(item.priority.rawValue.capitalized)
                        // Change the color of the text based on the priority.
                        .foregroundColor(listViewModel.getPriorityColor(priority: item.priority))
                }
                // Use a larger font size for the title and add some vertical padding.
                .font(.title2)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            // Use a background color to highlight the row when it is tapped.
            .background(Color.clear
                            .contentShape(Rectangle())
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(10))
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
}
struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(title: "First Item", priority: .high, isCompleted: true)
    static var item2 = ItemModel(title: "Second Item", priority: .low, isCompleted: false)
    static var previews: some View {
        let viewModel = ListViewModel()
        Group{
            ListRowView(item: item1, listViewModel: viewModel)
            ListRowView(item: item2, listViewModel: viewModel)
        }
        .previewLayout(.sizeThatFits)
    }
}
