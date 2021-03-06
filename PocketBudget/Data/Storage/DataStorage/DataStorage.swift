//
//  DataStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

protocol AccountStorage {
    func get(by query: AccountsQuery) -> Observable<[Account]>
    func add(account: Account)
    func removeAccount(identifiedBy id: String)
}

protocol ExpenseStorage {
    func get(by query: ExpensesQuery) -> Observable<[Expense]>
    func add(expense: Expense)
    func removeExpense(identifiedBy id: String)
}

protocol MonthStorage {
    func get(by query: MonthsQuery) -> Observable<[Month]>
}

protocol TransactionStorage {
    func get(by query: TransactionsQuery) -> Observable<[Transaction]>
}

protocol DataStorage: AccountStorage, ExpenseStorage, MonthStorage, TransactionStorage {
}
