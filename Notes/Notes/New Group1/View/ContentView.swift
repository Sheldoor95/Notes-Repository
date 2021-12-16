//
//  ContentView.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var modalType: ModalType? = nil
    var body: some View {
        NavigationView {
            List() {
                ForEach(dataStore.filteredNotes) { note in
                    Button {
                        modalType = .update(note)
                    }label: {
                        Text("\(Date.now.formatted(date: .numeric, time: .omitted))   \(note.content)")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.title3.weight(.semibold))
                            .foregroundColor(Color(.label))
                        Text(note.content)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .brightness(0.1)
                            .lineLimit(1)
                    }
                }.onDelete(perform: dataStore.deleteNote)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        modalType = .new
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
        }
        .sheet(item: $modalType) { $0 }
        .searchable(text: $dataStore.filterText, prompt: Text("Search Notes"))
        .alert(item: $dataStore.appError) { appError in
            Alert(title: Text("Oh Oh"), message: Text( appError.error.localizedDescription))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataStore())
    }
}
