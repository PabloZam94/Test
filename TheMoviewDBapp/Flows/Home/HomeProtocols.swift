//
//  HomeProtocols.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

// MARK: ROUTER -
protocol HomeRouterProtocol: AnyObject {
    func goToMovieDetail(vc: UIViewController, movieID: Int)
    func goToProfile(vc: UIViewController, sessionID: String)
}

// MARK: PRESENTER -
protocol HomePresenterProtocol: AnyObject {
    func requestMovies(url: String) 
    func passMovieData(data: MoviesResponse?)
    func instantiateMovieDetail(vc: UIViewController, movieID: Int)
    func instantiateProfile(vc: UIViewController, sessionID: String)
}

// MARK: INTERACTOR -
protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    func getMovies(url: String) 
}

// MARK:  VIEW -
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    func successGetMovies(data: MoviesResponse)
    func failGetMovies()
}
