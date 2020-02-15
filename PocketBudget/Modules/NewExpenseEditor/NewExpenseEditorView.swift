//
//  NewExpenseEditorView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

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
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension NewExpenseEditorViewController: NewExpenseEditorView {
}
