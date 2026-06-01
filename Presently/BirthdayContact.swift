//
//  BirthdayContact.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import Foundation

struct BirthdayContact: Codable, Identifiable {
    var id: String
    var givenName: String
    var familyName: String
    var birthday: DateComponents?
    var thumbnailImageData: Data?

    var displayName: String {
        let formatted = nameComponents.formatted(.name(style: .medium))
        return formatted.isEmpty ? "Unamed Contact" : formatted
    }

    var initials: String {
        let formatted = nameComponents.formatted(.name(style: .abbreviated))
        return formatted.isEmpty ? String(displayName.prefix(1)).uppercased() : formatted
    }

    var nameComponents: PersonNameComponents {
        PersonNameComponents(givenName: givenName, familyName: familyName)
    }

    static let example: BirthdayContact = {
        var components = DateComponents()
        components.day = 13
        components.month = 12
        components.year = 1989

        return BirthdayContact(id: "1", givenName: "Taylor", familyName: "Swift", birthday: components)
    }()
}
