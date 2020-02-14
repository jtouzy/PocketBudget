//
//  ApplicationStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class ApplicationStorage {
    static var current: DataStorage = UserDefaultsDataStorage()
}
