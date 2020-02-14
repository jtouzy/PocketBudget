//
//  RequiredExpensesEditorInteractor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

protocol RequiredExpensesEditorInteractor {
    func getRequiredExpenses(for accountId: String) -> Observable<[Expense]>
    func add(expense: Expense)
}

class RequiredExpensesEditorInteractorImpl {
    lazy var dataStorage: DataStorage = ApplicationStorage.current
}

extension RequiredExpensesEditorInteractorImpl: RequiredExpensesEditorInteractor {
    func getRequiredExpenses(for accountId: String) -> Observable<[Expense]> {
        return dataStorage.getRequiredExpenses(for: accountId)
            .flatMap {
                Observable.just($0.sorted(by: { $0.title.compare($1.title) == .orderedAscending }))
            }
    }
    
    func add(expense: Expense) {
        dataStorage.add(expense: expense)
    }
}
