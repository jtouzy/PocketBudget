//
//  AccountsEditorPresenter.swift
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
protocol AccountsEditorPresenter {
    var didSelectAccount: PublishRelay<AccountUI> { get }
    var didRemoveAccount: PublishRelay<AccountUI> { get }
    func getItemsDriver() -> Driver<[AccountUI]>
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class AccountsEditorPresenterImpl: AccountsEditorPresenter {
    weak var view: AccountsEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared
    lazy var interactor: AccountsEditorInteractor = AccountsEditorInteractorImpl()

    let didSelectAccount = PublishRelay<AccountUI>()
    let didRemoveAccount = PublishRelay<AccountUI>()
    let disposeBag = DisposeBag()

    init(view: AccountsEditorView) {
        self.view = view
        subscribeForSelectAccountAction(didSelectAccount)
        subscribeForRemoveAccountAction(didRemoveAccount)
    }

    func getItemsDriver() -> Driver<[AccountUI]> {
        return interactor.getAccounts()
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                let emptyModel = EmptyViewModel(
                    title: "accounts_editor_empty_title".localized,
                    actionTitle: "accounts_editor_empty_action".localized
                )
                self.view?.evaluateEmptiness(for: $0, model: emptyModel) { actionSignal in
                    // FIXME Add new account
                    //actionSignal.emit(to: self.didTapAddRelay).disposed(by: self.disposeBag)
                }
            })
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension AccountsEditorPresenterImpl {
    private func subscribeForSelectAccountAction(_ stream: PublishRelay<AccountUI>) {
        stream
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.wireframe.push(to: .accountSettings(accountId: item.id))
            })
            .disposed(by: disposeBag)
    }

    private func subscribeForRemoveAccountAction(_ stream: PublishRelay<AccountUI>) {
        stream
            .subscribe(onNext: { [weak self] item in
                self?.interactor.remove(identifiedBy: item.id)
            })
            .disposed(by: disposeBag)
    }
}
