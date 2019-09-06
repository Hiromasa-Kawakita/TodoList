//
//  TodoItem.swift
//  Collection_test
//
//  Created by 川北 紘正 on 2019/08/30.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var title = ""
    @objc dynamic var category = ""
}
