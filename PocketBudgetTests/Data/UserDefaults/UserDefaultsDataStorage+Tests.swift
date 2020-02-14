//
//  UserDefaultsDataStorage+Tests.swift
//  PocketBudgetTests
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import XCTest
@testable import PocketBudget

class UserDefaultsDataStorageTests: XCTestCase {
    override func setUp() {
        super.setUp()
        UserDefaults.standard.clearKeys()
    }
}

extension UserDefaultsDataStorageTests {
    func testGetRequiredExpensesObservable() {
        // Given
        let sut = UserDefaultsDataStorage()
        let expense1 = Expense(id: "expense_1", title: "title_1", accountId: "account_1")
        let expense2 = Expense(id: "expense_2", title: "title_2", accountId: "account_1")
        var received: [[Expense]] = []
        let exp = expectation(description: "testGetRequiredExpensesObservable")
        // When: Subscription
        _ = sut.getRequiredExpenses(for: "account_1")
            .subscribe(onNext: { result in
                received.append(result)
                if received.count == 2 {
                    exp.fulfill()
                }
            })
        // When: First add
        UserDefaults.standard.set(
            "[{\"id\": \"\(expense1.id)\",\"title\": \"\(expense1.title)\",\"accountId\": \"\(expense1.accountId)\"}]",
            forKey: .expenses
        )
        // When: Second add
        UserDefaults.standard.set(
            "[{\"id\": \"\(expense1.id)\",\"title\": \"\(expense1.title)\",\"accountId\": \"\(expense1.accountId)\"},{\"id\": \"\(expense2.id)\",\"title\": \"\(expense2.title)\",\"accountId\": \"\(expense2.accountId)\"}]",
            forKey: .expenses
        )
        // Then
        waitForExpectations(timeout: 0.1, handler: { _ in
            XCTAssertEqual([[expense1], [expense1, expense2]], received)
        })
    }
}
