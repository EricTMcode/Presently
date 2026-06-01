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

    var contactsWithBirthdays: [BirthdayContact] {
        contacts
            .filter { $0.birthday != nil }
            .sorted { lhs, rhs in
                let lhsDays = lhs.daysUntilBirthday() ?? .max
                let rhsDays = rhs.daysUntilBirthday() ?? .max

                if lhsDays == rhsDays {
                    return lhs.displayName.localizedStandardCompare(rhs.displayName) == .orderedAscending
                }

                return lhsDays < rhsDays
            }
    }

    var contactsWithoutBirthdays: [BirthdayContact] {
        contacts
            .filter { $0.birthday == nil }
            .sorted { lhs, rhs in
                lhs.displayName.localizedStandardCompare(rhs.displayName) == .orderedAscending
            }
    }

    let storageURL = URL.documentsDirectory.appending(path: "PresentlyContacts.json")

    init() {
        if let data = try? Data(contentsOf: storageURL), let stored = try? JSONDecoder().decode([BirthdayContact].self, from: data) {
            contacts = stored
        }
    }

    func save() {
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        try? data.write(to: storageURL, options: .atomic)
    }

    func add(_ newContacts: [BirthdayContact]) {
        guard newContacts.isEmpty == false else { return }
        contacts.append(contentsOf: newContacts)
        save()
    }

    func delete(_ contact: BirthdayContact) {
        contacts.removeAll { $0.id == contact.id }
        save()
    }
}
