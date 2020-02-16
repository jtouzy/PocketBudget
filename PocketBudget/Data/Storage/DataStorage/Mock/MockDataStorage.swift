//
//  MockDataStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

class MockDataStorage: DataStorage {
    let accountSubject = BehaviorSubject<[Account]>(value: [
        Account(
            id: "account_1",
            title: "Compte principal"
        )
    ])
    let expenseSubject = BehaviorSubject<[Expense]>(value: [
        Expense(
            id: "expense_1",
            title: "Expense 1",
            accountId: "account_1"
        )
    ])
}

//
// MARK: ACCOUNTSTORAGE IMPLEMENTATION
//
extension MockDataStorage {
    func get(by query: AccountsQuery) -> Observable<[Account]> {
        get(by: query, from: accountSubject)
    }
}

//
// MARK: EXPENSESTORAGE IMPLEMENTATION
//
extension MockDataStorage {
    func get(by query: ExpensesQuery) -> Observable<[Expense]> {
        get(by: query, from: expenseSubject)
    }
    func add(expense: Expense) {
        add(expense, to: expenseSubject)
    }
    func remove(expense: Expense) {
        remove(expense, to: expenseSubject)
    }
}

//
// MARK: PRIVATE COMMON FUNCTIONS
//
extension MockDataStorage {
    private func get<T>(by query: Query<T>, from subject: BehaviorSubject<[T]>) -> Observable<[T]> {
        return subject.flatMap {
            Observable.just(query.filter(from: $0))
        }
    }
    private func add<T>(_ item: T, to subject: BehaviorSubject<[T]>) {
        guard var value = try? subject.value() else { return }
        value.append(item)
        subject.onNext(value)
    }
    private func remove<T>(_ item: T, to subject: BehaviorSubject<[T]>) where T: Identifiable {
        guard
            var value = try? subject.value(),
            let index = value.firstIndex(where: { $0.id == item.id })
        else { return }
        value.remove(at: index)
        subject.onNext(value)
    }
}
