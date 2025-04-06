//
//  NotesListView.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI

struct NotesListView: View {
    
    @StateObject private var noteManager = NoteManager()
    
    @State private var searchText = ""
    @State private var showingAddNote = false
    @State private var showingAddGroup = false
    @State private var showingOnboarding = false
    
    @AppStorage("sessionsCount") private var sessionsCount = 0
    
    var filteredNotes: [Note] {
        let allNotes = noteManager.notes.sorted { (note: Note, notei: Note) in
            if note.isPinned != notei.isPinned {
                return note.isPinned > notei.isPinned
            }
            return note.createdDate > notei.createdDate
        }
        if searchText.isEmpty {
            return allNotes
        } else {
            return allNotes.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.content.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(noteManager.groups) { group in
                    Section(header: GroupHeader(group: group, noteManager: noteManager)) {
                        ForEach(filteredNotes.filter { $0.groupId == group.id }) { note in
                            NoteRow(note: note, noteManager: noteManager)
                        }
                    }
                }
                
                Section(header: Text("Ungrouped Notes")) {
                    ForEach(filteredNotes.filter { $0.groupId == nil }) { note in
                        NoteRow(note: note, noteManager: noteManager)
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BaseBarButtonItem(title: "Add Group", systemName: "folder.badge.plus") {
                        self.showingAddGroup = true
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    BaseBarButtonItem(title: "Add Note", systemName: "square.and.pencil") {
                        self.showingAddNote = true
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Notes")
            .sheet(isPresented: $showingAddNote) {
                NavigationStack {
                    EditNoteView(noteManager: noteManager, note: nil, onDismiss: {
                        
                    })
                }
            }
            .sheet(isPresented: $showingAddGroup) {
                AddGroupView(noteManager: noteManager)
            }
            .onAppear {
                if sessionsCount == 0 {
                    showingOnboarding.toggle()
                }
                sessionsCount += 1
            }
            .fullScreenCover(isPresented: $showingOnboarding) {
                OnboardingView()
                    .background(Color(.systemGroupedBackground))
            }
        }
    }
}
