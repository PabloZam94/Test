//
//  ProductInfoInteractor.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import Foundation

import UIKit

class ProductInfoInteractor: ProductInfoInteractorProtocol {
    weak var presenter: ProductInfoPresenterProtocol?
    
    func requestProductInfo(itemsId: String) {
        NetworkManager().getProductInfo(itemIds: itemsId) { result in
            self.presenter?.passProductInfoData(data: result)
        } onFailure: { error in
            self.presenter?.getErrorProductInfoData(error: error)
        }
    }
}
