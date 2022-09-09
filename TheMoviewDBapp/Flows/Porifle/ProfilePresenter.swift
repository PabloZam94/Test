//
//  ProfilePresenter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

class ProfilePresenter: ProfilePresenterProtocol {
    
    weak private var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    private let router: ProfileRouterProtocol?
    
    init(interface: ProfileViewProtocol, interactor: ProfileInteractorProtocol?, router: ProfileRouterProtocol ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    // INTERACTOR
    func requestAccountDetail(url: String) {
        interactor?.getAccountDetail(url: url)
    }
    
    func requestFavoritesMovies(url: String) {
        interactor?.getFavoritesMoview(url: url)
    }
    
    // VIEW
    func passDataAccountDetail(data: AccountResponse?) {
        DispatchQueue.main.async {
            if let fullData = data {
                self.view?.successGetAccountDetail(data: fullData)
            }else{
                self.view?.failGetAccountDetail()
            }
        }
    }
    
    func passDataFavoritesMovies(data: MoviesResponse?) {
        DispatchQueue.main.async {
            if let allData = data {
                self.view?.successGetFavoritesMovies(data: allData)
            }else{
                self.view?.failGetFavoritesMovies()
            }
        }
    }
    
}
