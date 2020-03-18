//
//  UserDefaultsConfigStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation
import RxSwift

class UserDefaultsConfigStorage {
    lazy var userDefaults = UserDefaults.standard
}

extension UserDefaultsConfigStorage: ConfigStorage {
    func applicationHasBeenStartedBefore() -> Bool {
        return userDefaults.has(key: ConfigStorageKey.applicationHasBeenStarted)
    }
}
