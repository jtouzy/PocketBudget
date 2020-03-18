//
//  ConfigStorage.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

protocol ConfigStorage {
    func applicationHasBeenStartedBefore() -> Bool
}
