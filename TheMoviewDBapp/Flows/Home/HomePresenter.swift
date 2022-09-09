//
//  HomePresenter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    
    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    private let router: HomeRouterProtocol?
    
    init(interface: HomeViewProtocol, interactor: HomeInteractorProtocol?, router: HomeRouterProtocol ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    // INTERACTOR MOVIES
    func requestMovies(url: String) {
        interactor?.getMovies(url: url)
    }
    
    func passMovieData(data: MoviesResponse?) {
        DispatchQueue.main.async {
            if let allData = data {
                self.view?.successGetMovies(data: allData)
            }else{
                self.view?.failGetMovies()
            }
        }
    }
    
    func instantiateMovieDetail(vc: UIViewController, movieID: Int) {
        router?.goToMovieDetail(vc: vc, movieID: movieID)
    }
    
    func instantiateProfile(vc: UIViewController, sessionID: String) {
        DispatchQueue.main.async {
            self.router?.goToProfile(vc: vc, sessionID: sessionID)
        }
        
    }
    
    
}
