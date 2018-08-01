//
//  AuthentificationViewController.swift
//  my_testProj
//
//  Created by mac-130-71 on 7/30/18.
//  Copyright © 2018 mac-130-71. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthentificationViewController: UIViewController {
    
    
    lazy var authObject: Auth = { return Auth.auth() }()
    
    //MARK:-UI references
    @IBOutlet weak var signInControl: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passWordLabel: UILabel!
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var confirmPasswordTextView: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        activityIndicator.isHidden = true
      
    }
    
    @IBAction func didSingMethodChange(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        if signInControl.selectedSegmentIndex == 0 {
            setUpSignUp()
        } else {
            setUpSignIn()
        }
    }
    
    
    @IBAction func didSignButtonClicked(_ sender: UIButton) {
        if signInControl.selectedSegmentIndex == 0 {
            didSignUpClick()
        } else {
            didSignInClick()
        }
    }
    
    @IBAction func wasEditingBegan(_ sender: Any) {
        emailLabel.text = ""
        emailTextView.textColor = UIColor.black
    }
  
    
    @IBAction func emailEditEnd(_ sender: UITextField) {
        if isEmailValid() && isInputFieldsValid() {
            changeSignButtonState(isEnabled: true)
            
        } else {
            changeSignButtonState(isEnabled: false)
        }
    }
    
    @IBAction func passwordEditBegan(_ sender: UITextField) {
        passwordTextView.text = ""
        passwordTextView.textColor = UIColor.black
    }
    
    
    @IBAction func passwordEditEnd(_ sender: UITextField) {
        let isButtonAvailiable = isPasswordValid(from: sender) && isInputFieldsValid()
        changeSignButtonState(isEnabled: isButtonAvailiable)
    }
    
    
    @IBAction func confirmPasswordEditBegan(_ sender: UITextField) {
        confirmPasswordTextView.text = ""
        confirmPasswordTextView.textColor = UIColor.black
    }
    
    
    @IBAction func confirmPasswordEditEnd(_ sender: UITextField) {
        let isButtonBeAvailiable = isPasswordValid(from: sender) && isInputFieldsValid()
        changeSignButtonState(isEnabled: isButtonBeAvailiable)
    }
    
    
    private func setUpSignUp() {
        clearFields()
        signInButton.setTitle(SignUpInOut.signUp, for: .normal)
        changeSignButtonState(isEnabled: false)
        signInControl.selectedSegmentIndex = 0
        confirmPasswordTextView.isHidden = false
    }
    
    
    private func setUpSignIn() {
        signInButton.setTitle(SignUpInOut.signIn, for: .normal)
        changeSignButtonState(isEnabled: false)
        confirmPasswordTextView.isHidden = true
    }
    
    private func clearFields() {
        emailTextView.text = ""
        passwordTextView.text = ""
        confirmPasswordTextView.text = ""
    }
    
    private func isInputFieldsValid() -> Bool {
        if signInControl.selectedSegmentIndex == 0 {
            return isEmailValid() && isPasswordValid(from: passwordTextView) && isPasswordValid(from: confirmPasswordTextView)
        } else {
            return isEmailValid() && isPasswordValid(from: passwordTextView)
        }
    }
    
    private func didSignUpClick() {
        guard let email = emailTextView.text, let password = passwordTextView.text, let confirmPassword = confirmPasswordTextView.text else {
            return
        }
        if password == confirmPassword {
            signUp(for: email, with: password)
        } else
        {
            //TODO: else!
        }
    }
    
    private func didSignInClick() {
        let email = emailTextView.text
        let password = passwordTextView.text
        if (email != nil && password != nil) {
            signIn(with: email!, password: password!)
        }
    }
 
    
    //TODO: [WARN] - doesn't work yet
    private func isEmailValid() -> Bool {
        guard let email = emailTextView.text, !email.isEmpty else {
            setWarning(for: emailLabel, message: SignUpInOut.emailIsRequired)
            return false
        }
        //set regular expression for emails here
        //TODO to google it
        return true
    }

    
    private func isPasswordValid(from passwordField: UITextField) -> Bool {
        guard let password = passwordField.text, !password.isEmpty else {
            setWarning(for: passWordLabel, message: SignUpInOut.passwordIsRequired)
            return false
        }
        if password.count >= 6 {                //because of Firebase limit
            passwordField.textColor = UIColor.blue
            setWarning(for: passWordLabel, message: "")
            return true
        } else {
            passwordField.textColor = UIColor.red
            setWarning(for: passWordLabel, message: SignUpInOut.didNotSatisfyConditionPasswordWarning)
        }
        return false
    }

    
    private func signUp(for email: String, with password: String) {
       showIndicatorProgress()
       authObject.createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
            self?.hideIndicatorProgress()
            if let errorDescription =  error?.localizedDescription {
                // make alert dialog with: (with: errorDescription, message: "error")
                print("\(errorDescription)")
            } else {
                self?.openMapStoryBoard()
            }
        })
    }
    
    
    private func signIn(with email: String, password: String) {
        showIndicatorProgress()
        authObject.signIn(withEmail: email, password: password) { [weak self] (user, error) in
            self?.hideIndicatorProgress()
            if let errorDescription =  error?.localizedDescription {
                // make alert dialog with: (with: errorDescription, message: nil)
                 print("\(errorDescription)")
            } else {
                self?.openMapStoryBoard()
            }
        }
    }
    
    
    private func changeSignButtonState(isEnabled: Bool) {
        signInButton.isEnabled = isEnabled
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.signInButton.alpha = isEnabled ? 1: 0
        })
    }
    
    private func setWarning(for label: UILabel, message: String){
        label.text = message
        label.isHidden = false
    }
    
    private func clearWarning(for label: UILabel) {
        label.text = ""
        label.isHidden = true
    }
    
    
    private func openMapStoryBoard() {
        let mapStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let mapController = mapStoryboard.instantiateInitialViewController() as? UITabBarController {
            mapController.modalPresentationStyle = .fullScreen
            UIApplication.shared.keyWindow?.rootViewController = mapController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            self.view.alpha = 0.0
            UIView.animate(withDuration: 0.5, animations: {[weak self] in
                self?.view.alpha = 1.0
            })
        }
    }

    private func showIndicatorProgress() {
        activityIndicator.startAnimating()
    }
    
    private func hideIndicatorProgress() {
        activityIndicator.stopAnimating()
    }
}


