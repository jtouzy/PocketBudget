//
//  ACWAccountTitleView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 18/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol ACWAccountTitleView: AccountCreationWizardView {
}

//
// MARK: VIEW CONTROLLER
//
class ACWAccountTitleViewController: AccountCreationWizardViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    let disposeBag = DisposeBag()
    var presenter: AccountCreationWizardPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "acw_account_title_title".localized
        titleTextField.becomeFirstResponder()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension ACWAccountTitleViewController {
    private func createBindings() {
        guard let presenter = presenter else { return }
        nextButton.rx.tap
            .map { self.titleTextField.text.orEmpty }
            .asSignal(onErrorJustReturn: "")
            .emit(to: presenter.didTapNextOnAccountTitle)
            .disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension ACWAccountTitleViewController: ACWAccountTitleView {
}
