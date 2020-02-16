//
//  String+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
