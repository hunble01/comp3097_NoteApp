//
//  EditNoteView.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI

struct EditNoteView: View {
    
    @ObservedObject var noteManager: NoteManager
    let note: Note?
    let onDismiss: (() -> Void)
    
    @State private var title: String
    @State private var content: String
    @State private var selectedGroupId: UUID?
    
    @Environment(\.dismiss) private var dismiss
    
    init(noteManager: NoteManager, note: Note?, onDismiss: @escaping (() -> Void)) {
        self.noteManager = noteManager
        self.note = note
        self.onDismiss = onDismiss
        _title = State(initialValue: note?.title ?? "")
        _content = State(initialValue: note?.content ?? "")
        _selectedGroupId = State(initialValue: note?.groupId)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
            }
            
            Section(header: Text("Content")) {
                TextViewRepresentable(text: $content)
                    .frame(height: 200)
            }
            
            Section(header: Text("Group")) {
                Picker("Group", selection: $selectedGroupId) {
                    Text("None").tag(UUID?.none)
                    ForEach(noteManager.groups) { group in
                        Text(group.name).tag(group.id as UUID?)
                    }
                }
            }
        }
        .navigationTitle(note == nil ? "New Note" : "Edit Note")
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                BaseBarButtonItem(title: "Notes", systemName: "chevron.leading") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .bottomBar) {
                BaseBarButtonItem(title: "Save", systemName: "square.and.arrow.down") {
                    let newNote = Note(
                        id: note?.id ?? UUID(),
                        title: title,
                        content: content,
                        isPinned: note?.isPinned ?? false,
                        groupId: selectedGroupId
                    )
                    if note == nil {
                        noteManager.addNote(newNote)
                    } else {
                        noteManager.updateNote(newNote)
                    }
                    dismiss()
                }
                .disabled(title.isEmpty)
                .opacity(title.isEmpty ? 0.5 : 1)
            }
            ToolbarItem(placement: .bottomBar) {
                if note != nil {
                    Button(action: { noteManager.deleteNote(note!); dismiss() }, label: {
                        HStack(spacing: 5) {
                            Image(systemName: "trash")
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                            Text("Delete Note")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        .padding(5)
                        .padding(.horizontal, 4)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(18)
                        .padding(.trailing, -6)
                    })
                }
            }
            ToolbarItem(placement: .bottomBar) {
                if let note = note {
                    BaseBarButtonItem(title: note.isPinned ? "Unpin" : "Save", systemName: "pin.fill") {
                        var updatedNote = note
                        updatedNote.isPinned = !note.isPinned
                        noteManager.updateNote(updatedNote)
                    }
                }
            }
        }
    }
}
