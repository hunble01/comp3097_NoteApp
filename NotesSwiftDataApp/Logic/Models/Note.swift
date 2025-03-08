//
//  Note.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var isPinned: Bool
    var groupId: UUID?
    var createdDate: Date
    
    init(id: UUID = UUID(), title: String, content: String, isPinned: Bool = false, groupId: UUID? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.isPinned = isPinned
        self.groupId = groupId
        self.createdDate = Date()
    }
}

struct NoteGroup: Identifiable, Codable {
    let id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
