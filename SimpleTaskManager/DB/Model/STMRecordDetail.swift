//
//  STMRecordDetail.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 16/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation
import MagicalRecord
//
extension STMRecordDetail {
    //
    public static func createTaskDetail(with description:String, isNotified:Bool) {
        //
        MagicalRecord.save(blockAndWait: { context in
            if let theRecord = STMRecordDetail.mr_createEntity(in: context) {
                theRecord.taskDescription = description
                theRecord.isNotificationOn = isNotified
            }
        })
    }
}
