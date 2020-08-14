//
//  LoginViewController.swift
//  lhsplanner
//
//  Created by Caye on 8/10/20.
//  Copyright © 2020 caye. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
   
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
   //sign in with textfield ui
//    var ref: DatabaseReference!
//    var databaseHandle: DatabaseHandle?
//
//    var postdata = [String]()
//    var postall = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

        //sign in with uitextfields
//        ref = Database.database().reference()

//        let userRef = ref.child("Hub")
        
//        userRef.queryOrdered(byChild: "email").observe(.value, with: { snapshot in

//        for child in snapshot.children {
//
//            let snap = child as! DataSnapshot
//
//            let userDict = snap.value as! [String:Any]
//
//            let userId = userDict["ID"]
//            let lastname = userDict["lastname"]
//            print("\(userId!)  \(lastname!)")
//
//
//        }
//                })
//
     //sign in with textfield ui
        
        //hiding keyboard
        self.hideKeyboardWhenTappedAround()
        
        //scroll view fit with keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    //round edges for buttons
    func setupViews() {
        loginButton.layer.cornerRadius = 8
        loginButton.layer.masksToBounds = true
        
        signUpButton.layer.cornerRadius = 8
        signUpButton.layer.masksToBounds = true
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //scrolling when keyboard is present
    @objc func keyboardWillShow(notification:NSNotification){

        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height - 8
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @IBAction func loginButtonPushed(_ sender: UIButton) {
        
        guard let firUser = Auth.auth().currentUser,
        let email = emailTextField.text,
        !email.isEmpty else { return }
        
        let userAttrs = ["email": email]
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
        if let error = error {
            assertionFailure(error.localizedDescription)
            return
        }
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
            })
        }
        
        //
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }

        authUI.delegate = self
//
        //sign in with textfield ui
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in

            if error == nil{
            guard let _ = user else {
                return

            }
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()

          }
            else{
             let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "Retry", style: .cancel, handler: nil)

              alertController.addAction(defaultAction)
              self.present(alertController, animated: true, completion: nil)
        }
             }


        Auth.auth().signIn(withEmail: emailTextField.text!,
                                      password: passwordTextField.text!)
    }
    
    @IBAction func signUpButtonPushed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.Segue.signUpSegue, sender: self)
    }
    
}

//hiding keyboards
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: FUIAuthDelegate {
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
                UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                User.setCurrent(user, writeToUserDefaults: true)
               
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                }
                    
//                } else {
//                self.performSegue(withIdentifier: Constants.Segue.signUpSegue, sender: self)
    
                }
        }
        })
    }
}
