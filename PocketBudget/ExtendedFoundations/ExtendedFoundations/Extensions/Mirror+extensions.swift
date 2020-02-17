//
//  Mirror+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 17/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

public extension Mirror {
    typealias MirrorItem = (key: String, value: Any)

    var childrenNotNil: [MirrorItem] {
        return children
            .compactMap { item -> MirrorItem? in
                guard let label = item.label, let value = unwrap(item.value) else { return nil }
                return MirrorItem(key: label, value: value)
            }
    }

    private func unwrap<T>(_ any: T) -> Any? {
        let mirror = Mirror(reflecting: any)
        return mirror.displayStyle == .optional ? mirror.children.first?.value : any
    }
}
