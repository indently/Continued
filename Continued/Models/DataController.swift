//
//  DataController.swift
//  Continued
//
//  Created by Federico on 25/04/2022.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TodoModel")
    
    init(inMemory: Bool = false) {
        if !inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { desc, error in
            print("Loaded data from Core Data!")
            
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    func addItem(context: NSManagedObjectContext) {
        let item = Item(context: context)
        
        item.id = UUID()
        item.date = Date()
        item.name = "Test Item"
        item.completed = false
        
        save(context: context)
    }
    
    func toggleCompleted(item: Item, context: NSManagedObjectContext) {
        item.date = Date()
        item.completed.toggle()
        
        save(context: context)
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Item saved.")
        } catch {
            print("We could not save the data...")
        }
    }
}
