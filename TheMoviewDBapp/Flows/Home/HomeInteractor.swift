//
//  HomeInteractor.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
    
    func getMovies(url: String) {
        NetworkManager().getMovies(url: url) { data in
            self.presenter?.passMovieData(data: data)
        }
    }
    
}
