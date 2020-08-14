//
//  StorageService.swift
//  lhsplanner
//
//  Created by Caye on 8/13/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit
import FirebaseStorage

let storage = Storage.storage()
let storageRef = storage.reference()
let notesRef = storageRef.child("notes")

struct StorageService {
    
}
