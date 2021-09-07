//
//  ViewController.swift
//  To Do
//
//  Created by Максим Лебедев on 06.09.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let segueIdentifier = "tasksSegue"
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        warnLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func displayWarningLabel(withText text: String ) {
        warnLabel.text = text
        
        self.warnLabel.alpha = 1
       
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              email != "", password != ""
        else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] user, error in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            
            self?.displayWarningLabel(withText: "User doesn`t exist")
        })
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              email != "", password != ""
        else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            
            if error == nil {
                if user != nil {
                    
                } else {
                    print("user is not created")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
}

