////
////  UserData.swift
////  lhsplanner
////
////  Created by Caye on 8/13/20.
////  Copyright © 2020 caye. All rights reserved.
////
//
//import Foundation
//import FirebaseDatabase.FIRDataSnapshot
//
//
//class UserData: Codable {
//
//    private static var _current: UserData?
//
//    static var current: UserData {
//
//          guard let currentUser = _current else {
//              fatalError("Error: current user doesn't exist")
//          }
//
//          return currentUser
//      }
//
//    static func setCurrent(_ user: UserData, {
//        _current = user
//    }
//
//        static func setCurrent(_ user: UserData, writeToUserDefaults: Bool = false) {
//            // 2
//            if writeToUserDefaults {
//                // 3
//                if let data = try? JSONEncoder().encode(user) {
//                    // 4
//                    UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
//                }
//            }
//
//            _current = user
//        }
//
//}
