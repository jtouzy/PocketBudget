//
//  MonthsQuery.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations

class MonthsQuery: Query<Month> {
    let id: String?
    let isCurrent: Bool?

    init(id: String? = nil, isCurrent: Bool? = nil) {
        self.id = id
        self.isCurrent = isCurrent
        super.init()
    }
}
