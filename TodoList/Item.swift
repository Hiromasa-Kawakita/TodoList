//
//  Item.swift
//  Collection_test
//
//  Created by 川北 紘正 on 2019/08/30.
//  Copyright © 2019 川北 紘正. All rights reserved.
//

import UIKit

class Item {
    var title: String
    var description: String
    var done: Bool = false
    
    
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description!
    }
    
}
