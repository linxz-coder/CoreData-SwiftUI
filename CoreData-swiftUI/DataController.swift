//
//  DataController.swift
//  CoreData-swiftUI
//
//  Created by 林晓中 on 2025/2/17.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "StudentInfo")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

