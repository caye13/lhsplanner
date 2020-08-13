//
//  CreateAccountViewController.swift
//  lhsplanner
//
//  Created by Caye on 8/12/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    @IBOutlet weak var enterPasswordConfirmTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setUpViews()

        
    }
    
    //round edges for buttons
    func setUpViews() {
        nextButton.layer.cornerRadius = 8
        nextButton.layer.masksToBounds = true
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func nextButtonPushed(_ sender: UIButton) {
        
        if enterPasswordTextField.text != enterPasswordConfirmTextField.text {
        let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
                }
        else{
        Auth.auth().createUser(withEmail: enterEmailTextField.text!, password: enterPasswordTextField.text!){ (user, error) in
         if error == nil {
           self.performSegue(withIdentifier: "signupToHome", sender: self)
                        }
         else{
           let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
           let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
               }
                    }
              }
        
        
//        guard let firUser = Auth.auth().currentUser,
//            let emailname = enterEmailTextField.text,
//            !emailname.isEmpty else { return }
//
//        let userAttrs = ["email": emailname]
//
//        let ref = Database.database().reference().child("users").child(firUser.uid)
//
//        ref.setValue(userAttrs) { (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return
//            }
//
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                let user = User(snapshot: snapshot)
//
//                // handle newly created user here
//            })
//        }
    }
    
}

