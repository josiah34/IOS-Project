//
//  ListRowView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
// Josiah Galloway 101296257
import SwiftUI

// Define a SwiftUI view named `ListRowView` that displays a single row of a list.
struct ListRowView: View {
    
    // `item` is an instance of the `ItemModel` struct that this row will display.
    let item: ItemModel
    
    // The body of the view contains the visual elements that will be displayed.
    var body: some View {
        HStack{
            // Display an image that shows a checkmark or an empty circle depending on whether the item is completed.
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                // Make the checkmark green and the empty circle red.
                .foregroundColor(item.isCompleted ? .green : .red)
            // Display the title of the item.
            Text(item.title)
            // Add a spacer to push the title to the left and the checkmark to the right.
            Spacer()
        }
        // Use a larger font size for the title and add some vertical padding.
        .font(.title2)
        .padding(.vertical, 8)
    }
}
struct ListRowView_Previews: PreviewProvider {
    static var item1 = ItemModel(title: "First Item", isCompleted: true)
    static var item2 = ItemModel(title: "Second Item", isCompleted: false)
    static var previews: some View {
        Group{
            ListRowView(item: item1)
            ListRowView(item: item2)
            
        }
        .previewLayout(.sizeThatFits)
    }
}
