//
//  SearchProtocols.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//


import UIKit

// MARK: ROUTER -
protocol SearchRouterProtocol: AnyObject {
    func showProductInfo(vc: UIViewController, itemID: String)
}

// MARK: PRESENTER -
protocol SearchPresenterProtocol: AnyObject {
    func callReuquestSearch(query: String)
    func passSearchRespons(data: SearchModel)
    func searchRequestError(error: RequestError)
    func instatiateProductInfo(vc: UIViewController, itemID: String)
}

// MARK: INTERACTOR -
protocol SearchInteractorProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    func requestSearch(searchQuery: String)
}

// MARK:  VIEW -
protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    func successGetSearch(data: SearchModel)
    func failureGetSearch(error: RequestError)
}


