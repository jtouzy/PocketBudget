//
//  AccountSettingsPresenter.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift

//
// MARK: PRESENTER PROTOCOL
//
protocol AccountSettingsPresenter {
    var didSelectSettingsItem: PublishRelay<AccountSettingsItem> { get }
    var itemsDriver: Driver<[AccountSettingsItem]> { get }
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class AccountSettingsPresenterImpl: AccountSettingsPresenter {
    weak var view: AccountSettingsView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared

    let didSelectSettingsItem = PublishRelay<AccountSettingsItem>()
    var itemsDriver: Driver<[AccountSettingsItem]> { settingItemsRelay.asDriver() }
    let settingItemsRelay = BehaviorRelay<[AccountSettingsItem]>(value: [
        .requiredExpenses
    ])
    let disposeBag = DisposeBag()

    let accountId: String

    init(view: AccountSettingsView, for accountId: String) {
        self.view = view
        self.accountId = accountId
        subscribeForSelectSettingsItemAction(didSelectSettingsItem)
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension AccountSettingsPresenterImpl {
    private func subscribeForSelectSettingsItemAction(_ stream: PublishRelay<AccountSettingsItem>) {
        stream
            .subscribe(onNext: { [weak self] item in
                // FIXME Navigate
            })
            .disposed(by: disposeBag)
    }
}
