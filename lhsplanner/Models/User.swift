//
//  User.swift
//  lhsplanner
//
//  Created by Caye on 8/13/20.
//  Copyright © 2020 caye. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User {
    let uid: String
    let email: String


    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let email = dict["email"] as? String
            else { return nil }

        self.uid = snapshot.key
        self.email = email
    }
}
