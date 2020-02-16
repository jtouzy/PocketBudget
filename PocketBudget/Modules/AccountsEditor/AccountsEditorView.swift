//
//  AccountsEditorView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol AccountsEditorView: class, UIEmptiable {
}

//
// MARK: VIEW CONTROLLER
//
class AccountsEditorViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: UITableViewCell.identifier)
        }
    }
    var emptyView: EmptyView?

    let disposeBag = DisposeBag()
    var presenter: AccountsEditorPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension AccountsEditorViewController {
    private func createBindings() {
        createTableViewBinding()
    }

    private func createTableViewBinding() {
        guard let presenter = presenter else { return }
        // Content driving
        tableView.bindContent(with: presenter.getItemsDriver(), cell: UITableViewCell.self) {
            $1.textLabel?.text = $0.title
        }.disposed(by: disposeBag)
        // Selection
        tableView.bindSelection(to: presenter.didSelectAccount).disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension AccountsEditorViewController: AccountsEditorView {
}
