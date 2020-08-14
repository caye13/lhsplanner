//
//  CreateAccountViewController.swift
//  lhsplanner
//
//  Created by Caye on 8/12/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
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
            //go to main view controller
            guard let _ = user else {
                return
            }

            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()

         }
         else{
           let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
           let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
         }
            }
            }
        
        guard let firUser = Auth.auth().currentUser,
            let email = enterEmailTextField.text,
            !email.isEmpty else { return }

        UserService.create(firUser, email: email) { (user) in
        guard let user = user else {
            return
        }

        User.setCurrent(user, writeToUserDefaults: true)

            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
        
    }
    
}

extension CreateAccountViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        guard let user = authDataResult?.user
            else { return }
        let userRef = Database.database().reference().child("users").child(user.uid)
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            if let user = User(snapshot: snapshot) {
                print("Welcome, \(user.email).")
            } else {
                print("error")
            }
        })
    }
}


