//
//  ModalType.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import SwiftUI

enum ModalType: Identifiable, View {
    case new
    case update(Note)
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:
            return NoteFormView(formVM: NoteFormViewModel())
        case .update(let note):
            return NoteFormView(formVM: NoteFormViewModel(note))
        }
    }
}

