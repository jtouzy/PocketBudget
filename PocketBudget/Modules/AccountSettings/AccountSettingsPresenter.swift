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
    var didTapCloseRelay: PublishRelay<()> { get }
    var didSelectSettingsItem: PublishRelay<AccountSettingsItem> { get }
    var itemsDriver: Driver<[AccountSettingsItem]> { get }
    func getSettingsTitle() -> Observable<String>
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class AccountSettingsPresenterImpl: AccountSettingsPresenter {
    weak var view: AccountSettingsView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared
    lazy var interactor: AccountSettingsInteractor = AccountSettingsInteractorImpl()

    let input: AccountSettingsModuleInput

    let didTapCloseRelay = PublishRelay<()>()
    let didSelectSettingsItem = PublishRelay<AccountSettingsItem>()
    var itemsDriver: Driver<[AccountSettingsItem]> { settingItemsRelay.asDriver() }
    let settingItemsRelay = BehaviorRelay<[AccountSettingsItem]>(value: [
        .fixedIncomes, .optionalIncomes, .requiredExpenses, .optionalExpenses
    ])
    let disposeBag = DisposeBag()

    init(view: AccountSettingsView, with input: AccountSettingsModuleInput) {
        self.view = view
        self.input = input
        subscribeForCloseAction(didTapCloseRelay)
        subscribeForSelectSettingsItemAction(didSelectSettingsItem)
    }

    func getSettingsTitle() -> Observable<String> {
        return interactor.getAccount(identifiedBy: input.accountId)
            .flatMap { Observable.just($0.title) }
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension AccountSettingsPresenterImpl {
    private func subscribeForCloseAction(_ stream: PublishRelay<()>) {
        stream
            .subscribe(onNext: { [weak self] in self?.wireframe.close() })
            .disposed(by: disposeBag)
    }

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
        case .fixedIncomes:
            fatalError("TODO")
        case .optionalIncomes:
            fatalError("TODO")
        case .requiredExpenses:
            return .expensesEditor(
                input: ExpensesEditorModuleInput(accountId: input.accountId, type: .required)
            )
        case .optionalExpenses:
            return .expensesEditor(
                input: ExpensesEditorModuleInput(accountId: input.accountId, type: .optional)
            )
        }
    }
}
