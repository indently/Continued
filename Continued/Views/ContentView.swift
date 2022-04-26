//
//  ContentView.swift
//  Continued
//
//  Created by Federico on 24/04/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        NavigationView {
            TabView(selection: $vm.selection) {
                ToDoView(vm: vm)
                    .tabItem { Label("Todo", systemImage: "tray.fill") }
                    .tag(Tabs.todo)
                
                ToDoView(vm: vm)
                    .tabItem { Label("Completed", systemImage: "tray.full.fill") }
                    .tag(Tabs.completed)
            }
            .navigationTitle("Todo App")
            .onChange(of: vm.selection) { newValue in
                vm.fetchItems()   
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        vm.addItem()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
