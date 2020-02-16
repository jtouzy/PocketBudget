//
//  UserDefaultsDataStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import Foundation
import RxSwift

class UserDefaultsDataStorage: DataStorage {
    lazy var userDefaults = UserDefaults.standard
}

//
// MARK: ACCOUNTSTORAGE IMPLEMENTATION
//
extension UserDefaultsDataStorage {
    func get(by query: AccountsQuery) -> Observable<[Account]> {
        return getObservable(forKey: .accounts, by: query)
    }
}

//
// MARK: EXPENSESTORAGE IMPLEMENTATION
//
extension UserDefaultsDataStorage {
    func get(by query: ExpensesQuery) -> Observable<[Expense]> {
        return getObservable(forKey: .expenses, by: query)
    }
    func add(expense: Expense) {
        add(expense, forKey: .expenses)
    }
    func remove(expense: Expense) {
        remove(expense, forKey: .expenses)
    }
}

extension UserDefaultsDataStorage {
    private func getObservable<T>(
        forKey key: UserDefaultsStorageKey,
        by query: Query<T>
    ) -> Observable<[T]> where T: Decodable {
        return userDefaults.rx
            .observe(String.self, key.rawValue)
            .compactMap { $0 }
            .flatMap { [weak self] jsonString -> Observable<[T]> in
                guard let self = self else { return GenericError.selfIsNil.asObservable() }
                return Observable.just(self.decode(from: jsonString))
            }
            .flatMap { Observable.just(query.filter(from: $0)) }
    }

    private func add<T>(
        _ item: T,
        forKey key: UserDefaultsStorageKey
    ) where T: Codable {
        var data: [T] = find(forKey: key)
        data.append(item)
        store(data, forKey: key)
    }

    private func remove<T>(
        _ item: T,
        forKey key: UserDefaultsStorageKey
    ) where T: Codable & Identifiable {
        var data: [T] = find(forKey: key)
        guard let index = data.firstIndex(where: { $0.id == item.id }) else { return }
        data.remove(at: index)
        store(data, forKey: key)
    }
}

extension UserDefaultsDataStorage {
    private func find<T>(forKey key: UserDefaultsStorageKey) -> [T] where T: Decodable {
        guard let stored: String = userDefaults.get(forKey: key) else {
            return []
        }
        return decode(from: stored)
    }

    private func store<T>(_ items: [T], forKey key: UserDefaultsStorageKey) where T: Encodable {
        do {
            let result = try JSONEncoder().encode(items)
            guard let jsonString = String(data: result, encoding: .utf8) else {
                return
            }
            userDefaults.set(jsonString, forKey: key)
        } catch {
            // FIXME: Log error
            return
        }
    }

    private func decode<T>(from jsonString: String) -> [T] where T: Decodable {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return []
        }
        do {
            return try JSONDecoder().decode(Array<T>.self, from: jsonData)
        } catch {
            // FIXME: Log error
            return []
        }
    }
}
