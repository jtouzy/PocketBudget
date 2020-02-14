//
//  DataStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

protocol DataStorage {
    func getRequiredExpenses(for accountId: String) -> Observable<[Expense]>
    func add(expense: Expense)
}
