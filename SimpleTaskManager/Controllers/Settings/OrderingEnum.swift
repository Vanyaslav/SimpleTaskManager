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
        guard let item = STMOrderingMannerEnum(rawValue: row) else { return "" }
        return item.title
    }
    
    static func manageOrdering(with row: Int) {
        UserDefaults.storeOrderingManner(with: row)
    }
    
    static func getStored() -> STMOrderingMannerEnum {
        STMOrderingMannerEnum(rawValue: UserDefaults.getOrderingManner())!
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
    
    public static func getManagingTitle() -> String {
        STMOrderingTypeEnum.getStored() == .date
            ? "taskDueDate"
            : "taskTitle"
    }
    
    public static func getTitle(row: Int) -> String {
        (STMOrderingTypeEnum(rawValue: row)?.title)!
    }
    
    static func manageOrdering(with row: Int) {
        UserDefaults.storeOrderingType(with: row)
    }
    
    static func getStored() -> STMOrderingTypeEnum {
        STMOrderingTypeEnum(rawValue: UserDefaults.getOrderingType())!
    }
}
//
/// Persistancy
extension UserDefaults {
    private static let storageKeyManner = "STMOrderingManner"
    private static let storageKeyType = "STMOrderingType"
    
    fileprivate static func storeOrderingManner(with manner: Int) {
        standard.set(manner, forKey: storageKeyManner)
    }
    
    fileprivate static func storeOrderingType(with type: Int) {
        standard.set(type, forKey: storageKeyType)
    }
    
    fileprivate static func getOrderingManner() -> Int {
        standard.integer(forKey: storageKeyManner)
    }
    
    fileprivate static func getOrderingType() -> Int {
        standard.integer(forKey: storageKeyType)
    }
}
