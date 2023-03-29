//
//  ListView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
// Josiah Galloway
//Edward Entecott 101190443


import SwiftUI

struct ListView: View {
    // Access the list of items through an environment object
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        // Use a ZStack to layer views
        ZStack {
            // If there are no items in the list, show the NoItemsView with a transition animation
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                // If there are items in the list, show them in a List
                List {
                    // Loop through each item in the list and display it in a ListRowView
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item, listViewModel: listViewModel)
                            // When a ListRowView is tapped, update the corresponding item with an animation
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    // Allow deleting items by swiping left, and moving them by dragging and dropping
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                // Use the PlainListStyle for the List
                .listStyle(PlainListStyle())
            }
        }
        // Set the navigation bar title to "Goal Getter"
        .navigationTitle("Goal Getter")
        // Set up the navigation bar items: an EditButton on the leading side, and a NavigationLink to the AddView on the trailing side
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        // Set up a NavigationView with a ListView as the root view and a new instance of ListViewModel as an environment object
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
