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
// MARK: VIEW CONSTANTS
//
struct MonthBalanceSpecs {
    static let amountTopSpacing: CGFloat = 16

    static func tableViewTopSpacing(using amountLabel: Label) -> CGFloat {
        return amountTopSpacing * 2 + amountLabel.frame.height
    }
}
private typealias Specs = MonthBalanceSpecs

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
            tableView.isHidden = true
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    var amountLabel: Label?
    var emptyView: EmptyView?
    var settingsAccessor: UIButton?

    let disposeBag = DisposeBag()
    var presenter: MonthBalancePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
        makeAppearanceAnimations()
    }
}

//
// MARK: PRIVATE ANIMATION FUNCTIONS
//
extension MonthBalanceViewController {
    private func makeAppearanceAnimations() {
        makeAmountAnimation { [weak self] in
            guard let self = self else { return }
            self.makeTableViewAnimation()
            self.makeSettingsAccessorAnimation()
        }
    }

    private func makeAmountAnimation(completion: @escaping () -> Void) {
        amountLabel = Label(frame: .zero)
        amountLabel?.font = AppFont.font(fromStyle: .title1)
        amountLabel?.text = "AmointText"
        amountLabel?.fromCenterToTop(
            in: view,
            topDistance: Specs.amountTopSpacing,
            completion: completion
        )
    }

    private func makeSettingsAccessorAnimation() {
        guard let amountLabel = self.amountLabel else { return }
        let baseButtonFrame = amountLabel.frame.updated(x: view.frame.maxX + 30)
        let settingsAccessor = UIButton(frame: baseButtonFrame)
        settingsAccessor.setImage(UIImage(systemName: "pencil"), for: .normal)
        settingsAccessor.alpha = 0
        settingsAccessor.backgroundColor = .materialTeal
        settingsAccessor.tintColor = .white
        settingsAccessor.layer.cornerRadius = settingsAccessor.frame.width / 2
        settingsAccessor.layer.shadowColor = UIColor.gray.cgColor
        settingsAccessor.layer.shadowOpacity = 0.5
        settingsAccessor.layer.shadowRadius = 5
        settingsAccessor.layer.shadowOffset = .zero
        view.addSubview(settingsAccessor)
        self.settingsAccessor = settingsAccessor
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.settingsAccessor?.frame = baseButtonFrame.updated(x: self.view.frame.maxX - amountLabel.frame.height - 16)
            self.settingsAccessor?.alpha = 1
        }
    }

    private func makeTableViewAnimation() {
        guard let amountLabel = self.amountLabel else { return }
        tableView.isHidden = false
        tableView.alpha = 0
        tableViewTopConstraint.constant = Specs.tableViewTopSpacing(using: amountLabel)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.tableView.alpha = 1
        }
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
