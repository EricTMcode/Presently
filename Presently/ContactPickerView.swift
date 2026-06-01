//
//  ContactPickerView.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import ContactsUI
import SwiftUI

struct ContactPickerView: UIViewControllerRepresentable {
    var onSelect: ([BirthdayContact]) -> Void

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator

        picker.displayedPropertyKeys = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactBirthdayKey,
            CNContactThumbnailImageDataKey
            ]

        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(OnSelect: onSelect)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        let onSelect: ([BirthdayContact]) -> Void

        init(OnSelect: @escaping ([BirthdayContact]) -> Void) {
            self.onSelect = OnSelect
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
            let people = contacts.map { contact in
                BirthdayContact(
                    id: contact.identifier,
                    givenName: contact.givenName,
                    familyName: contact.familyName,
                    birthday: contact.birthday,
                    thumbnailImageData: contact.thumbnailImageData
                )
            }

            onSelect(people)
        }
    }
}
