//
//  ProductInfoRouter.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

open class ProductInfoRouter: ProductInfoRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func getController(productID: String) -> UIViewController {
        
       // Generating module components
        let storyboard = UIStoryboard(name: "ProductInfo", bundle: Bundle(for: ProductInfoViewController.self))
        let view: ProductInfoViewController = storyboard.instantiateViewController(identifier: "ProductInfoViewController") as! ProductInfoViewController
        let interactor = ProductInfoInteractor()
        let router = ProductInfoRouter()
        let presenter = ProductInfoPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.itemId = productID
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
        
}
