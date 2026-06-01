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

    static let example: BirthdayContact = {
        var components = DateComponents()
        components.day = 13
        components.month = 12
        components.year = 1989

        return BirthdayContact(id: "1", givenName: "Taylor", familyName: "Swift", birthday: components)
    }()
}
