//
//  BirthdayStore.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import Foundation
import UserNotifications

@Observable @MainActor
class BirthdayStore {
    var contacts = [BirthdayContact]()

    let notificationLimit = 64
    let leadTimeKey = "ReminderLeadTime"

    var leadTime: ReminderLeadTime = .oneWeek {
        didSet {
            UserDefaults.standard.set(leadTime.rawValue, forKey: leadTimeKey)
            Task { await rescheduleNotifications() }
        }
    }

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

        if let rawValue = UserDefaults.standard.string(forKey: leadTimeKey), let stored = ReminderLeadTime(rawValue: rawValue) {
            leadTime = stored
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
        Task { await rescheduleNotifications() }
    }

    func delete(_ contact: BirthdayContact) {
        contacts.removeAll { $0.id == contact.id }
        save()
        Task { await rescheduleNotifications() }
    }

    func rescheduleNotifications() async {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()

        let upcoming = contactsWithBirthdays.prefix(notificationLimit)
        guard upcoming.isEmpty == false else { return }

        let granted = (try? await center.requestAuthorization(options: [.alert, .badge, .sound])) ?? false
        guard granted else { return }

        for contact in upcoming {
            guard let trigger = contact.reminderDateCompoments(leadTime: leadTime) else { continue }

            let content = UNMutableNotificationContent()
            content.title = "Birthday reminder"
            content.body = "Don't forget \(contact.displayName)'s birthday on \(contact.formattedBirthday ?? "")."
            content.sound = .default

            let request = UNNotificationRequest(
                identifier: contact.id,
                content: content,
                trigger: UNCalendarNotificationTrigger(dateMatching: trigger, repeats: true)
            )

            try? await center.add(request)
        }
    }
}
