//
//  ProfileRouter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

open class ProfileRouter: ProfileRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func getController(sessionID: String) -> UIViewController {
        
       // Generating module components
        let storyboard = UIStoryboard(name: "Profile", bundle: Bundle(for: ProfileViewController.self))
        let view: ProfileViewController = storyboard.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let presenter = ProfilePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.sessionID = sessionID
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }

        
}
