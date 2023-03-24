//
//  AddView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
//
// Josiah Galloway 101296257
//Ravkeerat Singh 101344680

import SwiftUI

// Define a SwiftUI view named `AddView` that allows users to add items to a to-do list.
struct AddView: View {
    
    // Use `@Environment` to get the presentation mode of the current view.
    // This will allow us to dismiss this view when the user is done adding an item.
    @Environment(\.presentationMode) var presentationMode
    
    // Use `@EnvironmentObject` to get the `ListViewModel`.
    // This will allow us to add the new item to the list.
    @EnvironmentObject var listViewModel: ListViewModel
    
    // Use `@State` to keep track of the text in the text field and whether to show an alert.
    @State var textFieldText: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        // Use a `ScrollView` to allow users to scroll if the keyboard covers the screen.
        ScrollView {
            VStack {
                // Use a `TextField` to allow users to enter text for the new item.
                TextField("Enter something", text: $textFieldText)
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .background(Color(uiColor: .systemGray6))
                    .frame(height: 55)
                
                // Use a `Button` to allow users to save the new item.
                Button(action: saveButtonPressed,
                       label: {
                        Text("SAVE")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        // Set the navigation title of the view to "Add an Item" with a pencil emoji.
        .navigationTitle("Add an Item ✏️")
        
        // Use an `alert` modifier to show an alert if the user tries to add an item with less than three characters.
        .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("To Do List task must be 3 characters or more"),
                      dismissButton: .default(Text("OK")))
            }
    }
    
    // This function is called when the user presses the "SAVE" button.
    func saveButtonPressed() {
        // If the text in the text field is appropriate, add the item to the list and dismiss the view.
        if textIsAppropriate(){
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    // This function checks whether the text in the text field is appropriate.
    // If the text is not appropriate, it shows an alert and returns `false`.
    // Otherwise, it returns `true`.
    func textIsAppropriate() -> Bool{
        if textFieldText.count < 3 {
            showAlert.toggle()
            return false
        }
        return true
    }
}

// Define a preview for the `AddView` to see how it looks in Xcode's canvas.
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        // Use `environmentObject` to provide a `ListViewModel` instance to the view.
        .environmentObject(ListViewModel())
    }
}
