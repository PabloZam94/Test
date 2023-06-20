//
//  ProductInfoProtocols.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import UIKit

// MARK: ROUTER -
protocol ProductInfoRouterProtocol: AnyObject {
}

// MARK: PRESENTER -
protocol ProductInfoPresenterProtocol: AnyObject {
    func callRequestProductInfo(itemIds: String)
    func passProductInfoData(data: [ProductInfoModel])
    func getErrorProductInfoData(error: RequestError)
}

// MARK: INTERACTOR -
protocol ProductInfoInteractorProtocol: AnyObject {
    var presenter: ProductInfoPresenterProtocol? { get set }
    func requestProductInfo(itemsId: String)
}

// MARK:  VIEW -
protocol ProductInfoViewProtocol: AnyObject {
    var presenter: ProductInfoPresenterProtocol? { get set }
    func successGetProductInfo(data: [ProductInfoModel])
    func failureGetProductInfo(error: RequestError)
}

