//
//  ProfileProtocols.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

// MARK: ROUTER -
protocol ProfileRouterProtocol: AnyObject {
}

// MARK: PRESENTER -
protocol ProfilePresenterProtocol: AnyObject {
    func requestAccountDetail(url: String) 
    func passDataAccountDetail(data: AccountResponse?)
    func requestFavoritesMovies(url: String)
    func passDataFavoritesMovies(data: MoviesResponse?)
}

// MARK: INTERACTOR -
protocol ProfileInteractorProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func getAccountDetail(url: String)
    func getFavoritesMoview(url: String)
}

// MARK:  VIEW -
protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func successGetAccountDetail(data: AccountResponse)
    func failGetAccountDetail()
    func successGetFavoritesMovies(data: MoviesResponse) 
    func failGetFavoritesMovies()
}

