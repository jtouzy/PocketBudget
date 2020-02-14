//
//  MockDataStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

class MockDataStorage: DataStorage {
    let subject = BehaviorSubject<[Expense]>(value: [
        Expense(id: "expense_1", title: "Expense 1", accountId: "account_1"),
        Expense(id: "expense_2", title: "Expense 2", accountId: "account_1")
    ])

    func getRequiredExpenses(for accountId: String) -> Observable<[Expense]> {
        return subject.flatMap {
            Observable.just($0.filter { $0.accountId == accountId })
        }
    }

    func add(expense: Expense) {
        guard var value = try? subject.value() else { return }
        value.append(expense)
        subject.onNext(value)
    }
}
