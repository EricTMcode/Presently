//
//  ContentView.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var store = BirthdayStore()
    @State private var showingPicker = false

    var body: some View {
        NavigationStack {
            Group {
                if store.contacts.isEmpty {
                    ContentUnavailableView {
                        Label("Choose Contacts", systemImage: "gift")
                    } description: {
                        Text("Select the people whose birhtdays you want to remember.")
                    } actions: {
                        Button("Select Contacts", systemImage: "person.crop.circle.badge.plus") {
                            showingPicker = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    BirthdayListView(store: store)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Add Contacts", systemImage: "person.crop.circle.badge.plus") {
                                    showingPicker = true
                                }
                            }
                        }
                }
            }
            .navigationTitle("Presently")
        }
        .sheet(isPresented: $showingPicker) {
            ContactPickerView { newContacts in
                store.add(newContacts)
            }
        }
    }
}

#Preview {
    ContentView()
}
