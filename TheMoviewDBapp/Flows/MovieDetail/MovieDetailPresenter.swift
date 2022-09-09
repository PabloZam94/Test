//
//  MovieDetailPresenter.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak private var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    private let router: MovieDetailRouterProtocol?
    
    init(interface: MovieDetailViewProtocol, interactor: MovieDetailInteractorProtocol?, router: MovieDetailRouterProtocol ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func requestMovieDetail(url: String) {
        interactor?.getMoviewDetail(url: url)
    }
    
    func passData(data: MovieDetailResponse?) {
        DispatchQueue.main.async {
            if let fullData = data {
                self.view?.successGetMovieDetail(data: fullData)
            }else{
                self.view?.failGetMovieDetail()
            }
        }
    }
    
}
