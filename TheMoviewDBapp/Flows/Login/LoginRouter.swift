//
//  LoginRouter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

open class LoginRouter: LoginRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func getController(token: String) -> UIViewController {
        
       // Generating module components
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle(for: LoginViewController.self))
        let view: LoginViewController = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        let interactor = LoginInteractor()
        let router = LoginRouter()
        let presenter = LoginPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        view.token = token
        
        return view
        
    }
    
    func goToHome(vc: UIViewController, sessionID: String) {
        let viewController = HomeRouter.getController(sessionID: sessionID)
        vc.navigationController?.pushViewController(viewController, animated: true)
    }
        
}
