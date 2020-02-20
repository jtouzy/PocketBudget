//
//  MonthBalanceInteractor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

protocol MonthBalanceInteractor {
    func getTransactions(for monthId: String) -> Observable<[Transaction]>
}

class MonthBalanceInteractorImpl {
    lazy var dataStorage: DataStorage = ApplicationStorage.current
}

extension MonthBalanceInteractorImpl: MonthBalanceInteractor {
    func getTransactions(for monthId: String) -> Observable<[Transaction]> {
        return dataStorage.get(by: TransactionsQuery(monthId: monthId))
    }
}
