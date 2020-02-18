//
//  ExpensesEditorInteractor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit
import RxSwift

protocol ExpensesEditorInteractor {
    func getExpenses(for accountId: String, of type: ExpenseType) -> Observable<[ExpenseUI]>
    func add(expense: Expense)
    func remove(expense: Expense)
}

class ExpensesEditorInteractorImpl {
    lazy var dataStorage: DataStorage = ApplicationStorage.current
}

extension ExpensesEditorInteractorImpl: ExpensesEditorInteractor {
    func getExpenses(for accountId: String, of type: ExpenseType) -> Observable<[ExpenseUI]> {
        return dataStorage.get(by: ExpensesQuery(type: type, accountId: accountId))
            .flatMap { expenses -> Observable<[ExpenseUI]> in
                return .just(
                    expenses.map {
                        ExpenseUI(
                            id: $0.id,
                            title: $0.title,
                            amount: NumberFormatter.format(from: $0.amount, with: .fr) ?? "",
                            color: UIColor.fromColor($0.color)
                        )
                    }
                    .sorted(by: { $0.title.compare($1.title) == .orderedAscending })
                )
            }
    }
    
    func add(expense: Expense) {
        dataStorage.add(expense: expense)
    }

    func remove(expense: Expense) {
        dataStorage.removeExpense(identifiedBy: expense.id)
    }
}
