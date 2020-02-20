//
//  MonthBalancePresenter.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxRelay
import RxSwift

//
// MARK: PRESENTER PROTOCOL
//
protocol MonthBalancePresenter {
    func getItemsDriver() -> Driver<[Transaction]>
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class MonthBalancePresenterImpl: MonthBalancePresenter {
    weak var view: MonthBalanceView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared
    lazy var interactor: MonthBalanceInteractor = MonthBalanceInteractorImpl()

    let input: MonthBalanceModuleInput

    // TODO relays
    let disposeBag = DisposeBag()

    init(view: MonthBalanceView, with input: MonthBalanceModuleInput) {
        self.view = view
        self.input = input
        // TODO call subscriptions
    }

    func getItemsDriver() -> Driver<[Transaction]> {
        return interactor.getTransactions(for: input.monthId)
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                let emptyViewModel = EmptyViewModel(
                    title: "month_balance_empty_title".localized,
                    actionTitle: "month_balance_empty_action".localized
                )
                self.view?.evaluateEmptiness(for: $0, model: emptyViewModel) { _ in
                    // TODO call add
                    // $0.emit(to: self.didTapAddRelay).disposed(by: self.disposeBag)
                }
            })
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension MonthBalancePresenterImpl {
    // TODO private subscriptions
}
