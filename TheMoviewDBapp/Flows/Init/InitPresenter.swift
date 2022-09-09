//
//  InitPresenter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class InitPresenter: InitPresenterProtocol {
    
    weak private var view: InitViewProtocol?
    var interactor: InitInteractorProtocol?
    private let router: InitRouterProtocol?
    
    init(interface: InitViewProtocol, interactor: InitInteractorProtocol?, router: InitRouterProtocol ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func instanceNewView(vc: UIViewController, requestToken: String) {
        router?.goToLogin(vc: vc, token: requestToken)
    }
    
    func requesToken() {
        interactor?.getToken()
    }
    
    func passData(data: RequesTokenResponse?) {
        DispatchQueue.main.async {
            if let fullData = data {
                self.view?.successGetToken(data: fullData)
            }else{
                self.view?.failGetToken()
            }
        }
    }
    
}

