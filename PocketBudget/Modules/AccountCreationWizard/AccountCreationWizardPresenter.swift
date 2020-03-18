//
//  AccountCreationWizardPresenter.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 18/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift

//
// MARK: PRESENTER PROTOCOL
//
protocol AccountCreationWizardPresenter {
    var didTapNextOnAccountTitle: PublishRelay<String> { get }
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class AccountCreationWizardPresenterImpl: AccountCreationWizardPresenter {
    weak var view: AccountCreationWizardView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared

    let input: AccountCreationWizardModuleInput

    let didTapNextOnAccountTitle = PublishRelay<String>()
    let disposeBag = DisposeBag()

    var title: String?

    init(view: AccountCreationWizardView, with input: AccountCreationWizardModuleInput) {
        self.view = view
        self.input = input
        subscribeForNextOnAccountTitle(didTapNextOnAccountTitle)
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension AccountCreationWizardPresenterImpl {
    private func subscribeForNextOnAccountTitle(_ stream: PublishRelay<String>) {
        stream
            .subscribe(onNext: { [weak self] title in
                self?.title = title
            })
            .disposed(by: disposeBag)
    }
}
