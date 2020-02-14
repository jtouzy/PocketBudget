//
//  UserDefaults+extensions.swift
//  PocketBudgetTests
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation
@testable import PocketBudget

extension UserDefaults {
    func clearKeys() {
        UserDefaultsStorageKey.allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
}
