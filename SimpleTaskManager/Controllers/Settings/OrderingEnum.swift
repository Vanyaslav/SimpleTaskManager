//
//  OrderingEnum.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation

enum STMOrderingMannerEnum: Int, CaseIterable {
    case ascending = 0, descending
    
    var title: String {
        switch self {
        case .ascending: return "Ascending"
        case .descending: return "Descending"
        }
    }
    
    var actionBool: Bool {
        switch self {
        case .ascending: return true
        case .descending: return false
        }
    }
}

enum STMOrderingTypeEnum: Int, CaseIterable {
    case date = 0, name
    
    var title: String {
        switch self {
        case .date: return "By Due Date"
        case .name: return "By Name"
        }
    }
    
    func managingParameter() -> String {
        self == .date
            ? "taskDueDate"
            : "taskTitle"
    }
}
