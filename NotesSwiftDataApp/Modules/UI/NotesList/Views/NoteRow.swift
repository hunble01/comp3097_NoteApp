//
//  NoteRow.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI

struct NoteRow: View {
    let note: Note
    @ObservedObject var noteManager: NoteManager
    @State private var showingEditNote = false
    
    var pinActionColor: Color {
        if note.isPinned {
            return .red
        } else {
            return .yellow
        }
    }
    
    var body: some View {
        NavigationLink(destination: WrappedEditNoteView(note: note, noteManager: noteManager)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(.headline)
                    Text(note.content)
                        .font(.subheadline)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .swipeActions {
            Button(action: {
                withAnimation {
                    noteManager.togglePin(note)
                }
            }, label: {
                Image(systemName: note.isPinned ? "pin.fill" : "pin.fill")
            })
            .tint(pinActionColor)
        }
    }
}

struct WrappedEditNoteView: View {
    
    let note: Note
    @ObservedObject var noteManager: NoteManager
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            NavigationStack {
                EditNoteView(noteManager: noteManager, note: note, onDismiss: {
                    presentationMode.wrappedValue.dismiss()
                })
                .toolbarVisibility(.hidden, for: .navigationBar)
                .toolbarVisibility(.visible, for: .bottomBar)
            }
        }
    }
}
