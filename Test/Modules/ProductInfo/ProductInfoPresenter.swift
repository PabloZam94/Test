//
//  ProductInfoPresenter.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

class ProductInfoPresenter: ProductInfoPresenterProtocol {
    
    weak private var view: ProductInfoViewProtocol?
    var interactor: ProductInfoInteractorProtocol?
    private let router: ProductInfoRouterProtocol?
    
    init(interface: ProductInfoViewProtocol, interactor: ProductInfoInteractorProtocol?, router: ProductInfoRouterProtocol ) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    // INTERCATOR
    func callRequestProductInfo(itemIds: String) {
        interactor?.requestProductInfo(itemsId: itemIds)
    }
    
    // VIEW
    func passProductInfoData(data: [ProductInfoModel]) {
        view?.successGetProductInfo(data: data)
    }
    
    func getErrorProductInfoData(error: RequestError) {
        view?.failureGetProductInfo(error: error)
    }
    
}
