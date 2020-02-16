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
    func getItemsDriver() -> Driver<[AccountUI]>
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class AccountsEditorPresenterImpl: AccountsEditorPresenter {
    weak var view: AccountsEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared

    let didSelectAccount = PublishRelay<AccountUI>()
    let disposeBag = DisposeBag()

    init(view: AccountsEditorView) {
        self.view = view
        subscribeForSelectAccountAction(didSelectAccount)
    }

    func getItemsDriver() -> Driver<[AccountUI]> {
        return
            Observable.just([
                AccountUI(id: "account_1", title: "Compte principal")
            ])
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                self.view?.evaluateEmptiness(for: $0) { actionSignal in
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
}
