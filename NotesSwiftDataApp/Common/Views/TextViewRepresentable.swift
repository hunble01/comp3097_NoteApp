//
//  TextViewRepresentable.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI
import UIKit

struct TextViewRepresentable: UIViewControllerRepresentable {
    @Binding var text: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        let textView = UITextView(frame: vc.view.bounds)
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 16)
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.view.addSubview(textView)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let textView = uiViewController.view.subviews.first as? UITextView {
            textView.text = text
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewRepresentable
        
        init(_ parent: TextViewRepresentable) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}
