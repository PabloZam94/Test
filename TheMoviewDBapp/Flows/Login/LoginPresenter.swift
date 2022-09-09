//
//  LoginPresenter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {
    
    weak private var view: LoginViewProtocol?
    var interactor: LoginInteractorProtocol?
    private let router: LoginRouterProtocol?
    
    init(interface: LoginViewProtocol, interactor: LoginInteractorProtocol?, router: LoginRouterProtocol ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    // INTERACTOR
    func requestLogin(loginData: objecLogin) {
        interactor?.Login(object: loginData)
    }
    
    func passData(data: RequesTokenResponse?) {
        DispatchQueue.main.async {
            if let allData = data {
                self.view?.successLogin(data: allData)
            }else{
                self.view?.failLogin()
            }
        }
    }
    
    func requestSessionID(requestToken: String) {
        interactor?.GetSessionID(token: requestToken)
    }
    
    func passSessionID(data: SessionResponse?) {
        DispatchQueue.main.async {
            if let allData = data {
                self.view?.successGetSessionID(data: allData)
            }else{
                self.view?.failGetSessionID()
            }
        }
    }

    // ROUTER
    func instantiateHomeView(vc: UIViewController, sessionID: String) {
        router?.goToHome(vc: vc, sessionID: sessionID)
    }
    
}
