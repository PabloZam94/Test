//
//  LoginProtocols.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//


import UIKit

// MARK: ROUTER -
protocol LoginRouterProtocol: AnyObject {
    func goToHome(vc: UIViewController, sessionID: String)
}

// MARK: PRESENTER -
protocol LoginPresenterProtocol: AnyObject {
    func requestLogin(loginData: objecLogin)
    func passData(data: RequesTokenResponse?)
    func instantiateHomeView(vc: UIViewController, sessionID: String)
    
    func requestSessionID(requestToken: String)
    func passSessionID(data: SessionResponse?)
}

// MARK: INTERACTOR -
protocol LoginInteractorProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    func Login(object: objecLogin)
    func GetSessionID(token: String)
}

// MARK:  VIEW -
protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    func successLogin(data: RequesTokenResponse)
    func failLogin()
    func successGetSessionID(data: SessionResponse)
    func failGetSessionID()
}


