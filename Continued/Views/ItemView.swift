//
//  ItemView.swift
//  Continued
//
//  Created by Federico on 25/04/2022.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var vm: ViewModel
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(item.name ?? "Default")")
                Spacer()
                Text("\(item.completed.description)")
                    .bold()
            }
            Text("\(item.date?.formatted() ?? "Default")")
                .font(.footnote)
            
        }
        .onTapGesture {
            vm.toggleCompleted(item: item, toggleValue: vm.toggleValue)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemView(vm: ViewModel(),item: ViewModel().items[0])
    }
}
