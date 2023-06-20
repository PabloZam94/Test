//
//  SearchPresenter.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

class SearchPresenter: SearchPresenterProtocol {
    
    weak private var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    private let router: SearchRouterProtocol?
    
    init(interface: SearchViewProtocol, interactor: SearchInteractorProtocol?, router: SearchRouterProtocol ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    // INTERACTOR
    func requestSearch(searchQuery: String) {
        interactor?.requestSearch(searchQuery: searchQuery)
    }
    
    // PRESENTER
    func callReuquestSearch(query: String) {
        interactor?.requestSearch(searchQuery: query)
    }
    
    func passSearchRespons(data: SearchModel) {
        view?.successGetSearch(data: data)
    }
    
    func searchRequestError(error: RequestError) {
        self.view?.failureGetSearch(error: error)
    }

    // ROUTER
    func instatiateProductInfo(vc: UIViewController, itemID: String) {
        router?.showProductInfo(vc: vc, itemID: itemID)
    }
    
}
