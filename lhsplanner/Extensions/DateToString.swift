//
//  DateToString.swift
//  lhsplanner
//
//  Created by Caye on 8/13/20.
//  Copyright © 2020 caye. All rights reserved.
//

import Foundation

// date/time/etc for modificationtime
extension Date {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}

extension NSDate {
    func convertToString() -> String {
        return DateFormatter.localizedString(from: (self as Date), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
}
