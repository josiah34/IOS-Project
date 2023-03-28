//
//  AddView.swift
//  GoalGetter
//
//  Created by mac on 2023-03-22.
//
// Josiah Galloway 101296257

import SwiftUI
struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter something", text: $textFieldText)
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .background(Color(uiColor: .systemGray6))
                    .frame(height: 55)
                
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
        .navigationTitle("Add an Item ✏️")
        .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("To Do List task must be 3 characters or more"),
                      dismissButton: .default(Text("OK")))
            }    }
    func saveButtonPressed() {
        if textIsAppropriate(){
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
            
        }
        
    }
    
    func textIsAppropriate() -> Bool{
        if textFieldText.count < 3 {
            showAlert.toggle()
            return false
        }
        return true
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
