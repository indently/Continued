//
//  Content-ViewModel.swift
//  Continued
//
//  Created by Federico on 25/04/2022.
//

import Foundation
import CoreData
import SwiftUI


final class ViewModel: ObservableObject {
    @Published var selection: Tabs = .todo
    @Published var items: [Item] = [Item]()
    
    private var dc: DataController
    private var moc: NSManagedObjectContext
    
    init() {
        dc = DataController(inMemory: true)
        moc = dc.container.viewContext
        
        fetchItems()
    }
    
    func fetchItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            let itemsFetched = try moc.fetch(request)
            items = filterItems(items: itemsFetched, tab: selection)
            
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
            items = []
        }
        
        if items.isEmpty {
            addSampleItems()
        }
        
    }
    
    private func filterItems(items: [Item], tab: Tabs) -> [Item] {
        var newItems: [Item] = [Item]()
        
        print(items)
        
        switch tab {
        case .todo:
            newItems = items.filter { !$0.completed }
        case .completed:
            newItems = items.filter { $0.completed }
        }

        return newItems.sorted { $0.date! > $1.date! }
        
    }
    
    private func addSampleItems() {
        for _ in 1...10 {
            addItem()
        }
    }
    
    func toggleCompleted(item: Item) {
        dc.toggleCompleted(item: item, context: moc)
        let currentItem = items.first { $0.id == item.id}!
        objectWillChange.send()
        
        currentItem.completed = true
        currentItem.name = "Changed!"
        currentItem.date = Date()
        
        withAnimation {
            items = filterItems(items: items, tab: .todo)
        }
        
    }
    
    func addItem() {
        dc.addItem(context: moc)
        withAnimation {
            fetchItems()
        }
    }
}

enum Tabs {
    case todo, completed
}

