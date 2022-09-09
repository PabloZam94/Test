//
//  InitInteractor.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class InitInteractor: InitInteractorProtocol {

    weak var presenter: InitPresenterProtocol?
    
    func getToken() {
        NetworkManager().getRequesToken(url: Endpoints.BaseURL + Endpoints.AuthToken + Constats.pathAPI + Constats.apiKey) { data in
            self.presenter?.passData(data: data)
        }
    }
    
}
