//
//  STMEnum.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation

//
enum STMTaskStatusEnum {
    case completeTask, incompleteTask
    
    var labelTitle: String {
        switch self {
        case .incompleteTask:   return "Finish Task!"
        case .completeTask:     return "Undo Finish!"
        }
    }
    
    var tableHeaderTitle: String {
        switch self {
        case .incompleteTask:   return "Incompleted Tasks"
        case .completeTask:     return "Completed Tasks"
        }
    }
}
