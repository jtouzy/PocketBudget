//
//  RequiredExpensesEditorView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol RequiredExpensesEditorView: class {
}

//
// MARK: VIEW CONTROLLER
//
class RequiredExpensesEditorViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var addButton: UIButton!

    let disposeBag = DisposeBag()
    var presenter: RequiredExpensesEditorPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
    }

    func createBindings() {
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
extension RequiredExpensesEditorViewController: RequiredExpensesEditorView {
}

//
// MARK: VIEW CONTROLLER + TABLEVIEW
//
extension RequiredExpensesEditorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
