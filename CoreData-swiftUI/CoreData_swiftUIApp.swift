//
//  CoreData_swiftUIApp.swift
//  CoreData-swiftUI
//
//  Created by 林晓中 on 2025/2/17.
//

import SwiftUI

@main
struct CoreData_swiftUIApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
