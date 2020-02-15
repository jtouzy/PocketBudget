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

    func getRequiredExpenses(for accountId: String) -> Observable<[Expense]> {
        return userDefaults.rx
            .observe(String.self, UserDefaultsStorageKey.expenses.rawValue)
            .compactMap { $0 }
            .flatMap { [weak self] jsonString -> Observable<[Expense]> in
                guard let self = self else { return GenericError.selfIsNil.asObservable() }
                return Observable.just(self.decodeExpenses(from: jsonString))
            }
    }

    func add(expense: Expense) {
        var expenses: [Expense] = findExpenses()
        expenses.append(expense)
        storeExpenses(expenses)
    }

    func remove(expense: Expense) {
        var expenses: [Expense] = findExpenses()
        guard let index = expenses.firstIndex(where: { $0.id == expense.id }) else { return }
        expenses.remove(at: index)
        storeExpenses(expenses)
    }
}

extension UserDefaultsDataStorage {
    private func findExpenses() -> [Expense] {
        guard let storedExpenses: String = userDefaults.get(forKey: .expenses) else {
            return []
        }
        return decodeExpenses(from: storedExpenses)
    }

    private func decodeExpenses(from jsonString: String) -> [Expense] {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return []
        }
        do {
            return try JSONDecoder().decode([Expense].self, from: jsonData)
        } catch {
            // FIXME: Log error
            return []
        }
    }

    private func storeExpenses(_ expenses: [Expense]) {
        do {
            let result = try JSONEncoder().encode(expenses)
            guard let jsonString = String(data: result, encoding: .utf8) else {
                return
            }
            userDefaults.set(jsonString, forKey: .expenses)
        } catch {
            // FIXME: Log error
            return
        }
    }
}
