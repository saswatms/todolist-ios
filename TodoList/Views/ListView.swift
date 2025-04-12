//
//  ListView.swift
//  TodoList
//
//  Created by Saswat Mishra on 11/04/25.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    var body: some View {
        ZStack{
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }
            else{          List {
                ForEach(listViewModel.items) { item in
                    ListRowView(item: item)
                        .onTapGesture {
                            withAnimation(.linear){
                                listViewModel.updateItem(item: item)
                            }
                        }
                }
                .onDelete(perform: listViewModel.deleteItems)
                .onMove(perform: listViewModel.moveItems)
            }
            .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("TODO List 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
    
}

#Preview {
    NavigationView{
        ListView()
    }.environmentObject(ListViewModel())
}

