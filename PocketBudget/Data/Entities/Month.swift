//
//  Month.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class Month: Codable {
    let id: String
    let isCurrent: Bool
    let balance: Double

    init(id: String, isCurrent: Bool, balance: Double) {
        self.id = id
        self.isCurrent = isCurrent
        self.balance = balance
    }
}
