//
//  ContentView.swift
//  CoreData-swiftUI
//
//  Created by 林晓中 on 2025/2/17.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    @State private var selectedStudent: Student?
    @State private var newName: String = ""
    @State private var isShow: Bool = false
    
    var body: some View {
        VStack {
            List(students){ student in
                HStack{
                    Text(student.name ?? "Unknown")
                    Spacer()
                    Button("Edit"){
                        selectedStudent = student
                        isShow.toggle()
                    }
                }.swipeActions(allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        moc.delete(student)
                        try? moc.save()
                    } label: {
                        Label("删除", systemImage: "trash")
                    }

                }
            }
            
            Button("Add"){
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Wealey"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? moc.save()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.extraLarge)
            .padding(.trailing, 20)
            
            
            
        }
        .padding()
        .sheet(isPresented: $isShow) {
            VStack {
                Text("Edit Student Name")
                    .font(.headline)
                
                TextField("Enter new name", text: $newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Save Changes") {
                    if let selectedStudent = selectedStudent {
                        selectedStudent.name = newName
                        try? moc.save()
                        //                        self.selectedStudent = nil // Close edit mode
                        isShow = false
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
    
}

#Preview {
    @Previewable @StateObject var dataController = DataController()
    
    ContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)
}
