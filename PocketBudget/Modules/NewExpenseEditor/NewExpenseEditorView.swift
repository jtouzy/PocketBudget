//
//  NewExpenseEditorView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol NewExpenseEditorView: class {
}

//
// MARK: VIEW CONTROLLER
//
class NewExpenseEditorViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!

    let disposeBag = DisposeBag()
    var presenter: NewExpenseEditorPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension NewExpenseEditorViewController {
    private func createBindings() {
        createAddButtonBinding()
    }

    private func createAddButtonBinding() {
        guard let presenter = presenter else { return }
        addButton.rx.tap
            .asSignal()
            .emit(to: presenter.didTapAddRelay)
            .disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension NewExpenseEditorViewController: NewExpenseEditorView {
}
