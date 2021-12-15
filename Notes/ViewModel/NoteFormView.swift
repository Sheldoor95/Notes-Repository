//
//  NoteFormView.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import SwiftUI

struct NoteFormView: View {
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM : NoteFormViewModel
    enum Field {
        case note
    }
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusField: Field?
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                TextField("Title...", text: $formVM.title)
                    .font(.largeTitle)
                    .focused($focusField, equals: .note)
                //                    .padding(.horizontal, 8)
                TextEditor(text: $formVM.content)
                    .focused($focusField, equals: .note)
                //                    .padding(.horizontal, 5)
                
                Spacer()
            }
            .padding()
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    focusField = .note
                }
            }
            
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
            
        }
    }
}

extension NoteFormView {
    func updateNote() {
        let note = Note(id: formVM.id!, title: formVM.title, content: formVM.content)
        dataStore.updateNote(note)
        dismiss()
    }
    
    func addNote() {
        let note = Note(title: formVM.title, content: formVM.content)
        dataStore.addNote(note)
        dataStore.loadNotes()
        dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button(formVM.updating ? "Update": "Save", action : formVM.updating ? updateNote : addNote)
            .disabled(formVM.isDisabled)
    }
}

struct NoteFormView_Previews: PreviewProvider {
    static var previews: some View {
        NoteFormView(formVM: NoteFormViewModel())
            .environmentObject(DataStore())
    }
}
