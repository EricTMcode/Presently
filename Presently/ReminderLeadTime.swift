//
//  ReminderLeadTime.swift
//  Presently
//
//  Created by Eric on 01/06/2026.
//

import Foundation

enum ReminderLeadTime: String, CaseIterable {
    case twoWeeks, oneWeek, sameDay

    var daysBeforeBirthday: Int {
        switch self {
        case .twoWeeks: return 14
        case .oneWeek: return 7
        case .sameDay: return 0
        }
    }

    var title: String {
        switch self {
        case .twoWeeks: "Two weeks before"
        case .oneWeek: "One week before"
        case .sameDay: "On the day"
        }
    }
}
