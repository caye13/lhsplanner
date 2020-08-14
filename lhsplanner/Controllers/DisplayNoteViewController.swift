//
//  DisplayNoteViewController.swift
//  lhsplanner
//
//  Created by Caye on 8/13/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DisplayNoteViewController: UIViewController {
    
    var note: Note?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    func noteNote() {
        let title = titleTextField.text
        let content = contentTextView.text
        
        let noteNote: [String : AnyObject] = ["title": title as AnyObject,
                                           "content": content as AnyObject]
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Sightings").childByAutoId().setValue(noteNote)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
            let destination = segue.destination as? ListNotesTableViewController
            else { return }

        switch identifier {
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""

            destination.tableView.reloadData()
            
          //  save()
        case "save" where note == nil:
            let note = Note()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modificationTime = Date()
            
            destination.notes.append(note)
            
            noteNote()
            
        case "cancel":
            print("cancel bar button item tapped")

        default:
            print("unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
            
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
        
}
