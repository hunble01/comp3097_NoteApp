//
//  Note.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import Foundation
import SwiftUI

enum TaskStatus: String, Codable, CaseIterable {
    case late = "Late"
    case inProgress = "In Progress"
    case inRevision = "In Revision"
    case completed = "Completed"
    
    var color: Color {
        switch self {
        case .late: return .red
        case .inProgress: return .blue
        case .inRevision: return .purple
        case .completed: return .green
        }
    }
}

struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var content: String
    var isPinned: Bool
    var groupId: UUID?
    var createdDate: Date
    var status: TaskStatus // New property
    
    init(id: UUID = UUID(), title: String, content: String, isPinned: Bool = false, groupId: UUID? = nil, status: TaskStatus = .inProgress) {
        self.id = id
        self.title = title
        self.content = content
        self.isPinned = isPinned
        self.groupId = groupId
        self.createdDate = Date()
        self.status = status
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
