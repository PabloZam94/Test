//
//  HomeRouter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

open class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func getController(sessionID: String) -> UIViewController {
        
       // Generating module components
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle(for: HomeViewController.self))
        let view: HomeViewController = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.sessionID = sessionID
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
    func goToMovieDetail(vc: UIViewController, movieID: Int) {
        let view = MovieDetailRouter.getController(movieID: movieID)
        vc.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToProfile(vc: UIViewController, sessionID: String) {
        let viewContoller = ProfileRouter.getController(sessionID: sessionID)
        vc.present(viewContoller, animated: true)
    }
        
}
