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
    
//    func saveNote() {
//        let title = titleTextField.text
//        let content = contentTextView.text
//
//        let note: [String? : String?] = ["title": title,
//                                           "content": content]
//
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//        ref.child("notes").childByAutoId().setValue(note)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var title = titleTextField.text ?? ""
        self.navigationItem.title = title
            
        //hide keyboard and scrolling when keyboard is present
        self.hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //segues back to home and items in navigation functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }

        switch identifier {
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modificationTime = Date()

            CoreDataHelper.saveNote()

        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modificationTime = Date()

            CoreDataHelper.saveNote()
            
        case "cancel":
            print("cancel bar button item tapped")

        default:
            print("unexpected segue identifier")
        }
    }
    
    // show note title and content when path is clicked on
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
    
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.contentTextView.contentInset
        contentInset.bottom = keyboardFrame.size.height - 8
        contentTextView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        contentTextView.contentInset = contentInset
    }
        
}

//hiding keyboards
extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func keyboardDisappear() {
        view.endEditing(true)
    }
}
