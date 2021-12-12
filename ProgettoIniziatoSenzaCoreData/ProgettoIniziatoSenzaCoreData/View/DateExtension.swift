//
//  DateExtension.swift
//  ProgettoIniziatoSenzaCoreData
//
//  Created by Gianluca Annina on 20/11/21.
//
import SwiftUI
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
