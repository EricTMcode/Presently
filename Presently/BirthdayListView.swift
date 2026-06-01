//
//  BirthdayListView.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import SwiftUI

struct BirthdayListView: View {
    var store: BirthdayStore

    var body: some View {
        let withBirthdays = store.contactsWithBirthdays
        let withoutBirthdays = store.contactsWithoutBirthdays

        List {
            if withBirthdays.isEmpty == false {
                Section {
                    ForEach(withBirthdays) { contact in
                        BirthdayRowView(contact: contact) {
                            store.delete(contact)
                        }
                    }
                }
            }

            if withoutBirthdays.isEmpty == false {
                Section("Birthday not set") {
                    ForEach(withoutBirthdays) { contact in
                        BirthdayRowView(contact: contact) {
                            store.delete(contact)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BirthdayListView(store: BirthdayStore())
}
