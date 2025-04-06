//
//  OnboardingView.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-10.
//


import SwiftUI
import UIOnboarding

struct OnboardingView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIOnboardingViewController

    func makeUIViewController(context: Context) -> UIOnboardingViewController {
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = context.coordinator
        onboardingController.view.backgroundColor = .systemGroupedBackground
        return onboardingController
    }
    
    func updateUIViewController(_ uiViewController: UIOnboardingViewController, context: Context) {}
    
    class Coordinator: NSObject, UIOnboardingViewControllerDelegate {
        func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
            onboardingViewController.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        return .init()
    }
}

// Define custom colors for the app's branding
extension UIColor {
    static let primaryTeal = UIColor(red: 0.18, green: 0.67, blue: 0.67, alpha: 1.0) // #2EABAB
    static let accentCoral = UIColor(red: 0.95, green: 0.49, blue: 0.42, alpha: 1.0) // #F27D6B
    static let backgroundGray = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0) // #F5F5F5
}

struct UIOnboardingHelper {
    static func setUpIcon() -> UIImage {
        return UIImage(systemName: "note.text")!
    }

    static func setUpFirstTitleLine() -> NSMutableAttributedString {
        .init(string: "Welcome to", attributes: [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 24, weight: .regular)
        ])
    }
    
    static func setUpSecondTitleLine() -> NSMutableAttributedString {
        .init(string: "TaskNotes", attributes: [
            .foregroundColor: UIColor.link,
            .font: UIFont.systemFont(ofSize: 28, weight: .bold)
        ])
    }

    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        return .init([
            .init(icon: .init(systemName: "pencil")!, // Icon suggestion: plus.circle
                  title: "Capture Your Tasks",
                  description: "Quickly add and edit tasks to stay organized on the go."),
            .init(icon: .init(systemName: "calendar")!, // Icon suggestion: calendar
                  title: "Set Due Dates",
                  description: "Schedule your tasks with due dates and never miss a deadline."),
            .init(icon: .init(systemName: "checkmark")!, // Icon suggestion: checkmark.circle
                  title: "Track Progress",
                  description: "Mark tasks as complete and celebrate your achievements.")
        ])
    }

    static func setUpNotice() -> UIOnboardingTextViewConfiguration {
        return .init(icon: .init(systemName: "info.circle")!, // Icon suggestion: info.circle
                     text: "Your tasks are securely stored and synced on your devices.",
                     linkTitle: "",
                     link: "https://www.tasknotes.app/privacy",
                     tint: .gray)
    }

    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "Get Started",
                     titleColor: .white,
                     backgroundColor: .link) // Rounded corners for a modern look
    }
}

extension UIOnboardingViewConfiguration {
    // UIOnboardingViewController init
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setUpIcon(),
                     firstTitleLine: UIOnboardingHelper.setUpFirstTitleLine(),
                     secondTitleLine: UIOnboardingHelper.setUpSecondTitleLine(),
                     features: UIOnboardingHelper.setUpFeatures(),
                     textViewConfiguration: UIOnboardingHelper.setUpNotice(),
                     buttonConfiguration: UIOnboardingHelper.setUpButton()) // Light gray background for clean UI
    }
}
