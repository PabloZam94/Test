//
//  LoginInteractor.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class LoginInteractor: LoginInteractorProtocol {
    weak var presenter: LoginPresenterProtocol?
    
    func Login(object: objecLogin) {
        NetworkManager().postLogin(url: Endpoints.BaseURL + Endpoints.AuthToken + "validate_with_login?api_key=" + Constats.apiKey, loginObject: object) { data in
            if let safeData = data {
                self.presenter?.passData(data: safeData)
            }else{
                self.presenter?.passData(data: data)
            }
            
        }
    }
    
    func GetSessionID(token: String) {
        NetworkManager().postCreateSession(url: Endpoints.BaseURL + Endpoints.AuthSession + Constats.pathAPI + Constats.apiKey, token: token) { data in
            guard let contentResponse = data else { return }
            self.presenter?.passSessionID(data: contentResponse)
        }
    }
    
}

