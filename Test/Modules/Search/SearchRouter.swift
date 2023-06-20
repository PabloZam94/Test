//
//  SearchRouter.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

open class SearchRouter: SearchRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func getController(token: String) -> UIViewController {
        
       // Generating module components
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: SearchViewController.self))
        let view: SearchViewController = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func showProductInfo(vc: UIViewController, itemID: String) {
        let viewController = ProductInfoRouter.getController(productID: itemID)
        vc.present(viewController, animated: true)
    }
}
