//
//  CoreDataHelper.swift
//  lhsplanner
//
//  Created by Caye on 8/14/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }

        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext

        return context
    }()
}
