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
}

protocol ExpenseStorage {
    func get(by query: ExpensesQuery) -> Observable<[Expense]>
    func add(expense: Expense)
    func remove(expense: Expense)
}

protocol DataStorage: AccountStorage, ExpenseStorage {
}
