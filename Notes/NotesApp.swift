//
//  NotesApp.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import SwiftUI

@main
struct NotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataStore())
        }
    }
}
