//
//  UserDefaults+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 16/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

public extension UserDefaults {
    func has(key: UserDefaultsKey) -> Bool {
        return value(forKey: key.rawValue) != nil
    }
    func set<T>(value: T, forKey key: UserDefaultsKey) {
        set(value, forKey: key.rawValue)
    }
    func value<T>(forKey key: UserDefaultsKey) -> T? {
        return value(forKey: key.rawValue) as? T
    }
}
