//
//  Notes.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import Foundation

struct Note: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var content: String
    
    static var sampleData: [Note] {
        [
            Note(title: "Recipe", content: "Eggs,etcc..")
        ]
        
    }
}
