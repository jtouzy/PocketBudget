//
//  Query.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 17/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

open class Query<T> {
    public init() {
    }

    public func filter<T>(items: [T]) -> [T] {
        let queries = Mirror(reflecting: self).childrenNotNil
        guard queries.count > 0 else {
            return items
        }
        return items.filter { account in
            let objectMirror = Mirror(reflecting: account)
            return queries.reduce(true) { previous, query in
                guard
                    let objectKey = objectMirror.children.first(where: { $0.label == query.key })
                else {
                    return false
                }
                return previous &&
                    String(describing: objectKey.value) == String(describing: query.value)
            }
        }
    }
}
