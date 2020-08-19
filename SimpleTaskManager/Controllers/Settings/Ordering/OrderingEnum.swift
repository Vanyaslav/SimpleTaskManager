//
//  OrderingEnum.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation

///
enum STMOrderingManner: Int, CaseIterable {
    //
    case ascending = 0, descending
    //
    private var title: String {
        switch self {
        case .ascending: return "Ascending"
        case .descending: return "Descending"
        }
    }
    //
    var actionBool: Bool {
        switch self {
        case .ascending: return true
        case .descending: return false
        }
    }
    //
    public static func getTitle(row: Int) -> String {
        return (STMOrderingManner(rawValue: row)?.title)!
    }
    //
    static func manageOrdering(with row: Int) {
        UserDefaults.storeOrderingManner(with: STMOrderingManner(rawValue: row)!)
    }
    //
    static func getStored() -> STMOrderingManner {
        return UserDefaults.getOrderingManner()
    }
}
///
enum STMOrderingType: Int, CaseIterable {
    //
    case date = 0, name
    //
    private var title: String {
        switch self {
        case .date: return "By Due Date"
        case .name: return "By Name"
        }
    }
    //
    public static func getOrderVariable() -> String {
        return STMOrderingType.getStored() == .date
            ? "taskDueDate"
            : "taskTitle"
    }
    //
    public static func getTitle(row: Int) -> String {
        return (STMOrderingType(rawValue: row)?.title)!
    }
    //
    static func manageOrdering(with row: Int) {
        UserDefaults.storeOrderingType(with: STMOrderingType(rawValue: row)!)
    }
    //
    static func getStored() -> STMOrderingType {
        return UserDefaults.getOrderingType()
    }
}
//
/// Persistancy
extension UserDefaults {
    private static let storageKeyManner = "STMOrderingManner"
    private static let storageKeyType = "STMOrderingType"
    //
    fileprivate static func storeOrderingManner(with manner: STMOrderingManner) {
        standard.set(manner.rawValue, forKey: storageKeyManner)
    }
    
    fileprivate static func storeOrderingType(with type: STMOrderingType) {
        standard.set(type.rawValue, forKey: storageKeyType)
    }
    
    fileprivate static func getOrderingManner() -> STMOrderingManner {
        return STMOrderingManner(rawValue: standard.integer(forKey: storageKeyManner))!
    }
    
    fileprivate static func getOrderingType() -> STMOrderingType {
        return STMOrderingType(rawValue: standard.integer(forKey: storageKeyType))!
    }
}
