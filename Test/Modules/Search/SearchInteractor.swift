//
//  SearchInteractor.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
    
    func requestSearch(searchQuery: String) {
        NetworkManager().getCategories(siteID: Constats.sitieID, searchQuery: searchQuery) { result in
            self.presenter?.passSearchRespons(data: result)
        } onFailure: { error in
            self.presenter?.searchRequestError(error: error)
        }
    }
    
}

