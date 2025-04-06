//
//  NoteManager.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import Foundation

class NoteManager: ObservableObject {
    @Published var notes: [Note] = []
    @Published var groups: [NoteGroup] = []
    
    private let notesFile = "notes.json"
    private let groupsFile = "groups.json"
    
    init() {
        loadData()
    }
    
    // CRUD for Notes
    func addNote(_ note: Note) {
        notes.append(note)
        saveData()
    }
    
    func updateNote(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index] = note
            saveData()
        }
    }
    
    func deleteNote(_ note: Note) {
        notes.removeAll { $0.id == note.id }
        saveData()
    }
    
    func togglePin(_ note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isPinned.toggle()
            saveData()
        }
    }
    
    // CRUD for Groups
    func addGroup(_ group: NoteGroup) {
        groups.append(group)
        saveData()
    }
    
    func deleteGroup(_ group: NoteGroup) {
        groups.removeAll { $0.id == group.id }
        notes.removeAll { $0.groupId == group.id }
        saveData()
    }
    
    // Persistence
    private func saveData() {
        let encoder = JSONEncoder()
        if let notesData = try? encoder.encode(notes),
           let groupsData = try? encoder.encode(groups) {
            let notesURL = getDocumentsDirectory().appendingPathComponent(notesFile)
            let groupsURL = getDocumentsDirectory().appendingPathComponent(groupsFile)
            try? notesData.write(to: notesURL)
            try? groupsData.write(to: groupsURL)
        }
    }
    
    private func loadData() {
        let decoder = JSONDecoder()
        let notesURL = getDocumentsDirectory().appendingPathComponent(notesFile)
        let groupsURL = getDocumentsDirectory().appendingPathComponent(groupsFile)
        
        if let notesData = try? Data(contentsOf: notesURL),
           let loadedNotes = try? decoder.decode([Note].self, from: notesData) {
            notes = loadedNotes
        }
        
        if let groupsData = try? Data(contentsOf: groupsURL),
           let loadedGroups = try? decoder.decode([NoteGroup].self, from: groupsData) {
            groups = loadedGroups
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
