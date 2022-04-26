//
//  ToDoView.swift
//  Continued
//
//  Created by Federico on 25/04/2022.
//

import SwiftUI
import CoreData

struct ToDoView: View {
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        List {
            ForEach(vm.items) { item in
                ItemView(vm: vm,item: item)
            }
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(vm: ViewModel())
    }
}
