//
//  Bool+Extensions.swift
//  NotesSwiftDataApp
//
//  Created by User on 2025-03-07.
//

import SwiftUI

extension Bool: Comparable {
    // Define less than (<) operator
    public static func <(lhs: Bool, rhs: Bool) -> Bool {
        switch (lhs, rhs) {
        case (false, true):
            return true
        case (true, false):
            return false
        default:
            return false // false == false, true == true
        }
    }
    
    // Define equality (==) operator (already exists, but included for completeness)
    public static func ==(lhs: Bool, rhs: Bool) -> Bool {
        return lhs == rhs
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

// Since Comparable requires only == and <, >= and <= are derived automatically,
// but we can explicitly define > for clarity if desired
extension Bool {
    public static func >(lhs: Bool, rhs: Bool) -> Bool {
        return rhs < lhs
    }
}
