//
//  ListViewModel.swift
//  TodoList
//
//  Created by Saswat Mishra on 11/04/25.
//

import Foundation

class ListViewModel: ObservableObject{
    @Published var items: [ItemModel] = []{
        didSet{
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    init() {
        getItems()
    }
    func getItems(){
//        let newItems = [
//            ItemModel(title: "Buy milk", isCompleted: false),
//            ItemModel(title: "Learn SwiftUI", isCompleted: false),
//            ItemModel(title: "Go for a walk", isCompleted: true)
//        ]
//        items.append(contentsOf: newItems)
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let decodedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else {return}
        self.items = decodedItems
    }
    func deleteItems(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    func moveItems(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    func addItem(title: String) {
        items.append(ItemModel(title: title, isCompleted: false))
    }
    func updateItem(item: ItemModel){
//        if let index = items.firstIndex{ (existingItem) -> Bool in
//            return existingItem.id == item.id
//        } {
//            
//        }
        if let index = items.firstIndex(where: { $0.id == item.id }){
//            items[index] = ItemModel(title: item.title, isCompleted: !item.isCompleted) // It'll create a new ItemModel but we want to update the same.
            items[index] = item.updateCompletion()
        }
    }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
