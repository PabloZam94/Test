//
//  ProfileInteractor.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 08/09/22.
//

import UIKit

class ProfileInteractor: ProfileInteractorProtocol {
    weak var presenter: ProfilePresenterProtocol?
    
    func getAccountDetail(url: String) {
        NetworkManager().getAccountDetail(url: url) { data in
            guard let allData = data else { return }
            self.presenter?.passDataAccountDetail(data: allData)
        }
    }
    
    func getFavoritesMoview(url: String) {
        NetworkManager().getMovies(url: url) { data in
            guard let allData = data else { return }
            self.presenter?.passDataFavoritesMovies(data: allData)
        }
    }
}

