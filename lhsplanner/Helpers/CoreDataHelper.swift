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
    //app delegate to get or use coredata
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }

        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext

        return context
    }()
    
    //note functions
    static func newNote() -> Note {
            let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note

            return note
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(note: Note) {
        context.delete(note)

        saveNote()
    }
    
    static func saveCompleteButton() {
        do {
            try context.save()
        } catch let error {
            print("error")
        }
    }
        
    static func retrieveNotes() -> [Note] {
        do {
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)

            return results
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")

            return []
        }
    }
    
}
