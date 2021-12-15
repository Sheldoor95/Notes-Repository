//
//  NoteError.swift
//  Notes
//
//  Created by Gian Marco Fantini on 13/12/21.
//

import Foundation

enum NoteError : Error, LocalizedError {
    case saveError
    case readError
    case decodingError
    case encodingError
    
    var errorDescription: String? {
        switch self {
        case .saveError:
            return NSLocalizedString("Could not save Notes, please reinstall the app.", comment: "")
        case .readError:
            return NSLocalizedString("Could not load Notes, please reinstall the app.", comment: "")
        case .decodingError:
            return NSLocalizedString("There was a problem loading your Notes, please create a new Note to start over.", comment: "")
        case.encodingError:
            return NSLocalizedString("Could not save Notes, please reinstall the app.", comment: "")
        }
    }
}


struct ErrorType: Identifiable {
    let id = UUID()
    let error: NoteError
}
