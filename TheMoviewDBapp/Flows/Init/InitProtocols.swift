//
//  InitProtocols.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

// MARK: ROUTER -
protocol InitRouterProtocol: AnyObject {
    func goToLogin(vc: UIViewController, token: String)
}

// MARK: PRESENTER -
protocol InitPresenterProtocol: AnyObject {
    func instanceNewView(vc: UIViewController, requestToken: String)
    func requesToken()
    func passData(data: RequesTokenResponse?)
}

// MARK: INTERACTOR -
protocol InitInteractorProtocol: AnyObject {
    var presenter: InitPresenterProtocol? { get set }
    func getToken() 
}

// MARK:  VIEW -
protocol InitViewProtocol: AnyObject {
    var presenter: InitPresenterProtocol? { get set }
    func successGetToken(data: RequesTokenResponse)
    func failGetToken()
}
