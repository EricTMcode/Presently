//
//  BirthdayRowView.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import SwiftUI

struct BirthdayRowView: View {
    var contact: BirthdayContact
    var onDelete: () -> Void

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BirthdayRowView(contact: .example) {}
}
