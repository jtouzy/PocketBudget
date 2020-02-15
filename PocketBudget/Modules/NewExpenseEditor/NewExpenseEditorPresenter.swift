//
//  NewExpenseEditorPresenter.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

//
// MARK: PRESENTER PROTOCOL
//
protocol NewExpenseEditorPresenter {
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class NewExpenseEditorPresenterImpl: NewExpenseEditorPresenter {
    weak var view: NewExpenseEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared

    init(view: NewExpenseEditorView) {
        self.view = view
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension NewExpenseEditorPresenterImpl {
}
