//
//  OrderingEnum.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation

///
enum STMOrderingMannerEnum: Int, CaseIterable {
    case ascending = 0, descending
    
    private var title: String {
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
    
    public static func getTitle(row: Int) -> String {
        (STMOrderingMannerEnum(rawValue: row)?.title)!
    }
    
    static func manageOrdering(with row: Int) {
        UserDefaults.storeOrderingManner(with: STMOrderingMannerEnum(rawValue: row)!)
    }
    
    static func getStored() -> STMOrderingMannerEnum {
        UserDefaults.getOrderingManner()
    }
}
///
enum STMOrderingTypeEnum: Int, CaseIterable {
    case date = 0, name
    
    private var title: String {
        switch self {
        case .date: return "By Due Date"
        case .name: return "By Name"
        }
    }
    
    public static func getOrderVariable() -> String {
        STMOrderingTypeEnum.getStored() == .date
            ? "taskDueDate"
            : "taskTitle"
    }
    
    public static func getTitle(row: Int) -> String {
        (STMOrderingTypeEnum(rawValue: row)?.title)!
    }
    
    static func manageOrdering(with row: Int) {
        UserDefaults.storeOrderingType(with: STMOrderingTypeEnum(rawValue: row)!)
    }
    
    static func getStored() -> STMOrderingTypeEnum {
        UserDefaults.getOrderingType()
    }
}
//
/// Persistancy
extension UserDefaults {
    private static let storageKeyManner = "STMOrderingManner"
    private static let storageKeyType = "STMOrderingType"
    
    fileprivate static func storeOrderingManner(with manner: STMOrderingMannerEnum) {
        standard.set(manner.rawValue, forKey: storageKeyManner)
    }
    
    fileprivate static func storeOrderingType(with type: STMOrderingTypeEnum) {
        standard.set(type.rawValue, forKey: storageKeyType)
    }
    
    fileprivate static func getOrderingManner() -> STMOrderingMannerEnum {
        STMOrderingMannerEnum(rawValue: standard.integer(forKey: storageKeyManner))!
    }
    
    fileprivate static func getOrderingType() -> STMOrderingTypeEnum {
        STMOrderingTypeEnum(rawValue: standard.integer(forKey: storageKeyType))!
    }
}
