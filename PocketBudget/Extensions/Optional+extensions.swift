//
//  Optional+extensions.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

extension Optional where Wrapped: Sequence {
    func ifNil(_ completion: @escaping () -> Wrapped) -> Wrapped {
        switch self {
            case .some(let collection):
                return collection
            case .none:
                return completion()
        }
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
