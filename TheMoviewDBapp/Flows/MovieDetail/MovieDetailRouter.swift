//
//  MovieDetailRouter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

open class MovieDetailRouter: MovieDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func getController(movieID: Int) -> UIViewController {
        
       // Generating module components
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: Bundle(for: MovieDetailViewController.self))
        let view: MovieDetailViewController = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.movieID = movieID
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
        
}
