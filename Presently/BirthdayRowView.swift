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

    var daysText: String {
        switch contact.daysUntilBirthday() {
        case .none: "No date"
        case .some(0): "Today"
        case .some(1): "Tonorrow"
        case .some(let days): "\(days) days"
        }
    }

    var ageText: String {
        guard contact.birthday != nil else { return "No reminder" }

        if let age = contact.ageTurning() {
            return "Turning \(age)"
        }

        return "Age unknown"
    }

    var body: some View {
        HStack {
            Group {
                if let data = contact.thumbnailImageData, let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Text(contact.initials)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.tint)
                }
            }
            .frame(width: 44, height: 44)
            .clipShape(.circle)
            .accessibilityHidden(true)

            VStack(alignment: .leading) {
                Text(contact.displayName)
                    .font(.headline)

                Text(contact.formattedBirthday ?? "Birthday not set")
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(daysText)
                    .font(.subheadline)
                    .bold()

                Text(ageText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .swipeActions {
            Button("Delete", systemImage: "trash", role: .destructive, action: onDelete)
        }
    }
}

#Preview {
    BirthdayRowView(contact: .example) {}
}
