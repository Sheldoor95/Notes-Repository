//
//  DataStore.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import Foundation
import SwiftUI

class DataStore: ObservableObject {
    @Published var notes:[Note] = []
    @Published var appError: ErrorType? = nil
    @Published var filterText = "" {
        didSet{
            if !filterText.isEmpty {
                filteredNotes = notes.filter{$0.title.lowercased().contains(filterText.lowercased())}
            }else{
                filteredNotes = notes
            }
        }
    }
    
    @Published var filteredNotes: [Note] = []
    
    init() {
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: fileName) {
            loadNotes()
        }
    }
    
    func addNote(_ note: Note) {
        notes.append(note)
        saveNotes()
    }
    
    func updateNote(_ note: Note) {
        guard let index = notes.firstIndex(where: {$0.id == note.id}) else { return }
        notes[index] = note
        saveNotes()
        filteredNotes[index] = note
    }
    
    func deleteNote(at indexSet: IndexSet) {
        notes.remove(atOffsets: indexSet)
        saveNotes()
        filteredNotes.remove(atOffsets: indexSet)
    }
    
    func loadNotes() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    notes = try decoder.decode([Note].self, from: data)
                    filteredNotes = notes
                } catch {
                    //                    print(NoteError.decodingError.localizedDescription)
                    appError = ErrorType(error: .decodingError)
                }
            case .failure(let error):
                //                print(error.localizedDescription)
                appError = ErrorType(error: error)
            }
        }
    }
    
    func saveNotes() {
        print("Saving notes to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(notes)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    //                    print(error.localizedDescription)
                    appError = ErrorType(error: error)
                }
            }
        } catch {
            //            print(NoteError.encodingError.localizedDescription)
            appError = ErrorType(error: .encodingError)
        }
    }
}
