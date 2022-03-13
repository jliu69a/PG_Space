//
//  KCDataViewController.swift
//  MyPgSpace
//
//  Created by Johnson Liu on 3/12/22.
//

import UIKit

class KCDataViewController: UIViewController {
    
    @IBOutlet weak var userNameTextfield: UITextField?
    @IBOutlet weak var passwordTextfield: UITextField?
    @IBOutlet weak var resultsLabel: UILabel?
    @IBOutlet weak var innerView: UIView?
    
    @IBOutlet weak var resultsTopSpace: NSLayoutConstraint!
    
    var selectedActionCode: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Keychain"
        
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedActionCode == PasswordConstants.kSavePassword || selectedActionCode == PasswordConstants.kUpdatePassword {
            innerView?.isHidden = false
            resultsTopSpace.constant = 125
        } else {
            innerView?.isHidden = true
            resultsTopSpace.constant = 35
        }
        
        userNameTextfield?.becomeFirstResponder()
        resultsLabel?.text = nil
    }
    
    @IBAction func processAction(_ sender: Any) {
        var resultLine: String = ""
        
        let helper = Helpers()
        let userName = userNameTextfield?.text ?? ""
        let password = passwordTextfield?.text ?? ""
        
        dismissKeyboards()
        
        switch selectedActionCode {
        case PasswordConstants.kSavePassword:
            resultLine = helper.savePasswordForKey(userName: userName, password: password)
        case PasswordConstants.kRetrievePassword:
            resultLine = helper.retrivePasswordForKey(userName: userName)
        case PasswordConstants.kUpdatePassword:
            resultLine = helper.updatePasswordForKey(userName: userName, password: password)
        case PasswordConstants.kDeletePassword:
            resultLine = helper.deletePasswordForKey(userName: userName)
        default:
            resultLine = ""
        }
        
        resultsLabel?.text = resultLine
    }
    
    func dismissKeyboards() {
        userNameTextfield?.resignFirstResponder()
        passwordTextfield?.resignFirstResponder()
    }
}

extension KCDataViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboards()
        return true
    }
}
