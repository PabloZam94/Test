//
//  MovieDetailProtocols.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

// MARK: ROUTER -
protocol MovieDetailRouterProtocol: AnyObject {
}

// MARK: PRESENTER -
protocol MovieDetailPresenterProtocol: AnyObject {
    func requestMovieDetail(url: String)
    func passData(data: MovieDetailResponse?)
}

// MARK: INTERACTOR -
protocol MovieDetailInteractorProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol? { get set }
    func getMoviewDetail(url: String) 
}

// MARK:  VIEW -
protocol MovieDetailViewProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol? { get set }
    func successGetMovieDetail(data: MovieDetailResponse) 
    func failGetMovieDetail()
}

