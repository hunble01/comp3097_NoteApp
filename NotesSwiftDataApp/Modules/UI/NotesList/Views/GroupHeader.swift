//
//  GroupHeader.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI

struct GroupHeader: View {
    let group: NoteGroup
    @ObservedObject var noteManager: NoteManager
    
    var body: some View {
        HStack {
            Text(group.name)
            Spacer()
            Button(action: { noteManager.deleteGroup(group) }, label: {
                HStack(spacing: 5) {
                    Image(systemName: "trash")
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text("Delete Group")
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
}
