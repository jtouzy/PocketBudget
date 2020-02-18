//
//  AccountSettingsInteractor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 18/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

protocol AccountSettingsInteractor {
    func getAccount(identifiedBy id: String) -> Observable<Account>
}

class AccountSettingsInteractorImpl {
    lazy var dataStorage: DataStorage = ApplicationStorage.current
}

extension AccountSettingsInteractorImpl: AccountSettingsInteractor {
    func getAccount(identifiedBy id: String) -> Observable<Account> {
        return dataStorage.get(by: AccountsQuery(id: id))
            .first(orError: BusinessError.unrecognizedAccountId)
    }
}
