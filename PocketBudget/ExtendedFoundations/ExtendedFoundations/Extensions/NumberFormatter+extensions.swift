//
//  NumberFormatter+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 18/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

public extension NumberFormatter {
    static func format(from number: Double, with locale: Locale = .current) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: number))
    }
}
