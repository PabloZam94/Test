//
//  MovieDetailInteractor.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import Foundation

import UIKit

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    weak var presenter: MovieDetailPresenterProtocol?
    
    func getMoviewDetail(url: String) {
        NetworkManager().getMovieDetail(url: url) { data in
            guard let allData = data else { return }
            self.presenter?.passData(data: allData)
        }
    }
}
