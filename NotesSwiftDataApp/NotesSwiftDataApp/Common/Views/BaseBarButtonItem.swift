//
//  BaseBarButtonItem.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI

struct BaseBarButtonItem: View {
    
    let title: String
    let systemName: String
    let backgroundColor: Color = Color(.link)
    let foregroundColor: Color = Color(.white)
    let action: (() -> Void)
    
    var body: some View {
        Button(action: { action() }, label: {
            HStack(spacing: 5) {
                Image(systemName: systemName)
                    .font(.caption2)
                    .fontWeight(.semibold)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding(6)
            .padding(.horizontal, 4)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(18)
            .padding(.trailing, -6)
        })
    }
}

struct BaseDismissBarButtonItem: View {
    
    let dismiss: () -> Void
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "multiply.circle.fill")
                .foregroundStyle(Color.gray.opacity(0.65))
                .symbolRenderingMode(.hierarchical)
        }
    }
}
