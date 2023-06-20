//
//  Networking.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import Foundation

struct NetworkManager {
    var network = ServiceNetwork.init(host: Constats.baseHost)
    func getCategories(siteID: String, searchQuery: String ,onSuccess: @escaping (SearchModel) -> Void, onFailure: @escaping(RequestError) -> Void) {
        
        let queryItems = [URLQueryItem(name: "q", value: searchQuery)]
        network.get(path: Endpoints.searchProduct(siteID), queryItems: queryItems, onComplete: { data, error, _, statusCode in
            switch statusCode {
            case .ok:
                if let data = data {
                    if let result = network.decode(jsonData: data, using: SearchModel.self) {
                       onSuccess(result)
                        return
                    } else if let result = network.decode(jsonData: data, using: SearchModel.self), statusCode != .ok {
                        onFailure(.customMessage(message: "Error get \(result.siteID ?? "")"))
                        return
                    }
                }
                onFailure(.decode)
            default:
                if let error = error {
                    onFailure(error)
                } else {
                    onFailure(.unknown)
                }
            }
        })
    }
    
    func getProductInfo(itemIds: String, onSuccess: @escaping ([ProductInfoModel]) -> Void, onFailure: @escaping (RequestError) -> Void) {
        let queryItems = [URLQueryItem(name: "ids", value: itemIds)]
        network.get(path: Endpoints.productoInfo, queryItems: queryItems) { data, error, response, statusCode in
            switch statusCode {
            case .ok:
                if let data = data {
                    if let result = network.decode(jsonData: data, using: [ProductInfoModel].self) {
                       onSuccess(result)
                        return
                    } else if let result = network.decode(jsonData: data, using: [ProductInfoModel].self), statusCode != .ok {
                        onFailure(.customMessage(message: "Error get \(result.count ?? 0)"))
                        return
                    }
                }
                onFailure(.decode)
            default:
                if let error = error {
                    onFailure(error)
                } else {
                    onFailure(.unknown)
                }
            }
        }
    }
}
