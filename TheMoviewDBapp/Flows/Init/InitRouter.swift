//
//  InitRouter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

open class InitRouter: InitRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func getController(form: Bool) -> UIViewController {
        
       // Generating module components
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: InitViewController.self))
        let view: InitViewController = storyboard.instantiateViewController(identifier: "InitViewController") as! InitViewController
        let interactor = InitInteractor()
        let router = InitRouter()
        let presenter = InitPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
        
    func goToLogin(vc: UIViewController, token: String) {
        let newViewController = LoginRouter.getController(token: token)
        vc.navigationController?.pushViewController(newViewController, animated: false)
    }
    
}
