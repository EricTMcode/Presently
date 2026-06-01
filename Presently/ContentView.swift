//
//  ContentView.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var store = BirthdayStore()

    var body: some View {
        NavigationStack {
            Group {
                if store.contacts.isEmpty {
                    ContentUnavailableView {
                        Label("Choose Contacts", systemImage: "gift")
                    } description: {
                        Text("Select the people whose birhtdays you want to remember.")
                    }
                } else {
                    List(store.contacts) { contact in
                        BirthdayRowView(contact: contact) {
                            store.delete(contact)
                        }
                    }
                }
            }
            .navigationTitle("Presently")
        }
    }
}

#Preview {
    ContentView()
}
