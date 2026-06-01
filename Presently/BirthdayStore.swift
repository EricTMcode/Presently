//
//  BirthdayStore.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import Foundation

@Observable @MainActor
class BirthdayStore {
    var contacts = [BirthdayContact]()

    func add(_ newContacts: [BirthdayContact]) {
        guard newContacts.isEmpty == false else { return }
        contacts.append(contentsOf: newContacts)
    }

    func delete(_ contact: BirthdayContact) {
        contacts.removeAll { $0.id == contact.id }
    }
}
