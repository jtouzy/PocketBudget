//
//  UserDefaults+extension.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation

extension UserDefaults {
    func get(forKey key: UserDefaultsStorageKey) -> String? {
        return string(forKey: key.rawValue)
    }

    func set(_ item: String, forKey key: UserDefaultsStorageKey) {
        set(item, forKey: key.rawValue)
    }
}
