//
//  AddGroupView.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI

struct AddGroupView: View {
    @ObservedObject var noteManager: NoteManager
    @State private var groupName = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Group Name", text: $groupName)
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    
                }
                ToolbarItem(placement: .confirmationAction) {
                    BaseBarButtonItem(title: "Add", systemName: "plus") {
                        let newGroup = NoteGroup(name: groupName)
                        noteManager.addGroup(newGroup)
                        dismiss()
                    }
                    .disabled(groupName.isEmpty)
                    .opacity(groupName.isEmpty ? 0.5 : 1)
                }
            }
        }
    }
}
