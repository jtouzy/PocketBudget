//
//  MonthBalanceView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol MonthBalanceView: class, UIEmptiable {
}

//
// MARK: VIEW CONTROLLER
//
class MonthBalanceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    var emptyView: EmptyView?

    let disposeBag = DisposeBag()
    var presenter: MonthBalancePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension MonthBalanceViewController {
    private func createBindings() {
        createTableViewBinding()
    }

    private func createTableViewBinding() {
        guard let presenter = presenter else { return }
        // Content driving
        tableView.bindContent(with: presenter.getItemsDriver(), cell: UITableViewCell.self) {
            $1.textLabel?.text = $0.title
            // $1.imageView?.image = UIImage(systemName: "number.circle.fill")
            // $1.imageView?.tintColor = $0.color
            $1.detailTextLabel?.text = String($0.amount)
        }.disposed(by: disposeBag)
        // Actions
        // tableView.bindDeletion(to: presenter.didRemoveExpense).disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension MonthBalanceViewController: MonthBalanceView {
}
