//
//  InitViewController.swift
//  TheMoviewDBapp
//
//  Created by pablo luis velazquez zamudio on 07/09/22.
//

import UIKit

class InitViewController: UIViewController {
    
    var presenter: InitPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.requesToken()
    }

}

// MARK: EXTENSION -
extension InitViewController: InitViewProtocol {
    func successGetToken(data: RequesTokenResponse) {
        self.presenter?.instanceNewView(vc: self, requestToken: data.request_token ?? "")
    }

    func failGetToken() {
        print("Somethings wrong")
    }
}


