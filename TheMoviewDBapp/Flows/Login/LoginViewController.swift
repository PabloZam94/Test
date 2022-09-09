//
//  LoginViewController.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

struct objecLogin: Codable {
    var username: String
    var password: String
    var request_token: String
}

class LoginViewController: UIViewController {
    
// MARK: PROTOCOL VAR -
    var presenter: LoginPresenterProtocol?

// MARK: @IBOUTELTS -
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
// MARK: PROPERTIES -
    var token = ""
    let loader = LoaderViewController.showLoader()
    
// MARK: LIFE CYCLE VIEW FUNC -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
    }
    
// MARK: SETUP FUNC -
    func setupUI() {
        let topColor = UIColor(red: 1/255, green: 48/255, blue: 102/255, alpha: 1).cgColor
        let bottomColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.view.setGrdientVertical(colors: [topColor, bottomColor])
        btnLogin.layer.cornerRadius = btnLogin.frame.height / 2
        self.navigationItem.hidesBackButton = true
    }
    
    func setupDelegates() {
        usernameField.returnKeyType = .next
        passwordField.returnKeyType = .done
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        usernameField.addTarget(self, action: #selector(usernameFieldDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(passFieldDidChange), for: .editingChanged)
    }
    
    func validateFillTextfield() {
        let active = usernameField.text != "" && passwordField.text != "" ? true : false
        let alpha = usernameField.text != "" && passwordField.text != "" ? 1 : 0.7
        btnLogin.isEnabled = active
        btnLogin.alpha = alpha
    }
    
// MARK: @IBACTIONS -
    @IBAction func LoginAction(_ sender: Any) {
        self.present(loader, animated: false)
        let object = objecLogin(username: usernameField.text ?? "", password: passwordField.text ?? "", request_token: token)
        presenter?.requestLogin(loginData: object)
    }
    
// MARK: @OBJC FUNC -
    @objc func usernameFieldDidChange(_ textField: UITextField) {
        validateFillTextfield()
    }
    
    @objc func passFieldDidChange(_ textField: UITextField) {
        validateFillTextfield()
    }
    
}

// MARK: EXTENSIONS -
extension LoginViewController: LoginViewProtocol {
    func successLogin(data: RequesTokenResponse) {
        presenter?.requestSessionID(requestToken: data.request_token ?? "")
    }
    
    func failLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loader.dismiss(animated: false)
            self.lblError.isHidden = false
        }
    }
    
    func successGetSessionID(data: SessionResponse) {
        print(data)
        lblError.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loader.dismiss(animated: false)
            self.usernameField.text = ""
            self.passwordField.text = ""
            self.presenter?.instantiateHomeView(vc: self, sessionID: data.session_id ?? "")
        }
    }
    
    func failGetSessionID() {
        lblError.text = "Somethings wrong, please try again"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loader.dismiss(animated: false)
            self.lblError.isHidden = false
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case usernameField:
            passwordField.becomeFirstResponder()
            
        default:
            self.view.endEditing(true)
            
        }
        
        return true
    }
}
