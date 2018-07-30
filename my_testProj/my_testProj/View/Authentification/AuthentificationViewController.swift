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
        //setupTapGestureForScrollView()
        
        
        
        activityIndicator.isHidden = true
        setUpSignIn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    @IBAction func didSingMethodChange(_ sender: UISegmentedControl) {
        if signInControl.selectedSegmentIndex == 1 {
            setUpSignUp()
            
        } else {
            //register
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
        passWordLabel.text = ""
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
        
       // clearFields()
       // signInControl.alpha = 1
        signInButton.setTitle(SignUpInOut.signIn, for: .normal)
        changeSignButtonState(isEnabled: false)
        //signInControl.selectedSegmentIndex = 1
        confirmPasswordTextView.isHidden = true
        
    }
    
    private func clearFields() {
        //        what about to clear labels
        
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
            // else!
        }
    }
    
    
    
    private func didSignInClick() {
        let email = emailTextView.text
        let password = passwordTextView.text
        if (email != nil && password != nil) {
            signIn(with: email!, password: password!)
        }
        
    }
    
    
    
    //[WARN] - doesn't work yet
    private func isEmailValid() -> Bool {
        
        guard let email = emailTextView.text, !email.isEmpty else {
            setWarning(for: emailLabel, message: SignUpInOut.emailIsRequired)
            return false
        }
     
        //set regular expression for emails here
        //TODO Google it! )

        return true

    }

    
    private func isPasswordValid(from passwordField: UITextField) -> Bool {
        
        guard let password = passwordField.text, !password.isEmpty else {
            setWarning(for: passWordLabel, message: SignUpInOut.passwordIsRequired)
            return false
        }
        if password.count >= 6 {
            passwordField.textColor = UIColor.blue
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
        
        print(user)
            
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
            print(user)
        }
    }
    
    
    
    private func changeSignButtonState(isEnabled: Bool) {
        
        signInButton.isEnabled = isEnabled
        
//        UIView.animate(withDuration: AnimationConstants.fadeTime, animations: { [weak self] in
//
//            self?.signButton.alpha = isEnabled ? 1: 0
//
//        })
        
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
    
    
    
//    private func setupTapGestureForScrollView() {
//
//        let didTap = #selector(didTapScrollView(_:))
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: didTap)
//        scrollView.addGestureRecognizer(tapGestureRecognizer)
//
//    }
//
//
//
//    @objc func didTapScrollView(_ sender: UIGestureRecognizer) {
//        emailTextView.resignFirstResponder()
//        passwordTextView.resignFirstResponder()
//        confirmPasswordTextView.resignFirstResponder()
//    }

    private func removeKeyboardObservers() {
        
        NotificationCenter.default.removeObserver(self)
        
    }

    private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            
            return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
        
    }
    
    
    
    private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }

    private func showIndicatorProgress() {
        activityIndicator.startAnimating()
    }
    
    private func hideIndicatorProgress() {
        activityIndicator.stopAnimating()
    }
    
}


