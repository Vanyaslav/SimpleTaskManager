//
//  OrderingEnum.swift
//  SimpleTaskManager
//
//  Created by Tomas Baculák on 17/04/2018.
//  Copyright © 2018 Tomas Baculák. All rights reserved.
//

import Foundation

///
enum STMOrderingManner: Int {
    //
    case ascending = 0, descending
    // the last one + 1
    static let numberOfManners = STMOrderingManner.descending.rawValue + 1
    //
    private var title: String {
        // return self.rawValue.capitalized
        switch self {
        case .ascending: return "Ascending"
        case .descending: return "Descending"
        }
    }
    //
    public static func getTitle(row:Int) -> String {
        return (STMOrderingManner(rawValue: row)?.title)!
    }
    //
    static func manageOrderingManner(with row:Int) {
        UserDefaults.storeOrderingManner(with: STMOrderingManner(rawValue: row)!)
    }
    //
    static func getStoredManner() -> STMOrderingManner {
        return UserDefaults.getOrderingManner()
    }
    //
    static let storageKey = "STMOrderingManner"
}
///
enum STMOrderingType: Int {
    //
    case date = 0, name
    // the last one + 1
    static let numberOfTypes = STMOrderingType.name.rawValue + 1
    //
    private var title: String {
        switch self {
        case .date: return "By Due Date"
        case .name: return "By Name"
        }
    }
    //
    public static func getTitle(row:Int) -> String {
        return (STMOrderingType(rawValue: row)?.title)!
    }
    //
    static func manageOrderingType(with row:Int) {
        UserDefaults.storeOrderingType(with: STMOrderingType(rawValue: row)!)
    }
    //
    static func getStoredType() -> STMOrderingType {
        return UserDefaults.getOrderingType()
    }
    //
    static let storageKey = "STMOrderingType"
}
//
/// Persistancy
extension UserDefaults {
    //
    fileprivate static func storeOrderingManner(with manner: STMOrderingManner) {
        standard.set(manner.rawValue, forKey: STMOrderingManner.storageKey)
    }
    //
    fileprivate static func storeOrderingType(with type: STMOrderingType) {
        standard.set(type.rawValue, forKey: STMOrderingType.storageKey)
    }
    //
    fileprivate static func getOrderingManner() -> STMOrderingManner {
        return STMOrderingManner(rawValue: standard.integer(forKey: STMOrderingManner.storageKey))!
    }
    //
    fileprivate static func getOrderingType() -> STMOrderingType {
        return STMOrderingType(rawValue: standard.integer(forKey: STMOrderingType.storageKey))!
    }
}
