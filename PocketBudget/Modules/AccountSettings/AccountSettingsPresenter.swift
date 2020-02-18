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

    let input: AccountSettingsModuleInput

    let didSelectSettingsItem = PublishRelay<AccountSettingsItem>()
    var itemsDriver: Driver<[AccountSettingsItem]> { settingItemsRelay.asDriver() }
    let settingItemsRelay = BehaviorRelay<[AccountSettingsItem]>(value: [
        .requiredExpenses, .optionalExpenses
    ])
    let disposeBag = DisposeBag()

    init(view: AccountSettingsView, with input: AccountSettingsModuleInput) {
        self.view = view
        self.input = input
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
                guard let self = self else { return }
                self.wireframe.push(to: self.getModule(for: item))
            })
            .disposed(by: disposeBag)
    }

    private func getModule(for settingsItem: AccountSettingsItem) -> ApplicationModule {
        switch settingsItem {
        case .optionalExpenses:
            return .expensesEditor(
                input: ExpensesEditorModuleInput(accountId: input.accountId, type: .optional)
            )
        case .requiredExpenses:
            return .expensesEditor(
                input: ExpensesEditorModuleInput(accountId: input.accountId, type: .required)
            )
        }
    }
}
