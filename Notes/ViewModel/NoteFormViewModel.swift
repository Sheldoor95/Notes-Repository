//
//  NoteFormViewModel.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import Foundation

class NoteFormViewModel: ObservableObject {
    @Published var title = ""
    @Published var content = ""
    var id: String?
    
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        title.isEmpty
//        content.isEmpty
    }
    
    init() {}
    
    init(_ currentNote: Note) {
        self.title = currentNote.title
        self.content = currentNote.content
        id = currentNote.id
    }
}
