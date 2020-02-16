//
//  AccountsEditorInteractor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

protocol AccountsEditorInteractor {
    func getAccounts() -> Observable<[AccountUI]>
}

class AccountsEditorInteractorImpl {
    lazy var dataStorage: DataStorage = ApplicationStorage.current
}

extension AccountsEditorInteractorImpl: AccountsEditorInteractor {
    func getAccounts() -> Observable<[AccountUI]> {
        return dataStorage.get(by: AccountsQuery())
            .map { $0.map { AccountUI(id: $0.id, title: $0.title) } }
    }
}
