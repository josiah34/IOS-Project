import SwiftUI



struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var selectedPriority: Priority = .medium
    @State var dueDate: Date?
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter something", text: $textFieldText)
                    .padding(.horizontal)
                    .cornerRadius(10)
                    .background(Color(uiColor: .systemGray6))
                    .frame(height: 55)
                
                Picker("Priority", selection: $selectedPriority) {
                    Text("High").tag(Priority.high)
                    Text("Medium").tag(Priority.medium)
                    Text("Low").tag(Priority.low)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                DatePicker(
                    "Due Date",
                    selection: Binding<Date>(
                        get: { dueDate ?? Date() },
                        set: { dueDate = $0 }
                    )
                )
                
                Button(action: saveButtonPressed) {
                    Text("SAVE")
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            .padding(14)
        }
        .navigationTitle("Add an Item ✏️")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text("To Do List task must be 3 characters or more"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText, priority: selectedPriority, dueDate: dueDate)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            showAlert.toggle()
            return false
        }
        return true
    }
}
