//
//  Endpoints.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import Foundation
public protocol EndpointsProtocol {
    var url: String { get }
    var filename: String { get }
}

public enum Endpoints: EndpointsProtocol {
    case searchProduct(String)
    case productoInfo
    
    public var url: String {
        switch self {
        case .searchProduct(let sitieID):
            return "/sites/\(sitieID)/search"
        case .productoInfo:
            return "/items"
        }
    }
    
    public var filename: String {
        switch self {
        case .searchProduct:
            return "error search"
        case .productoInfo:
            return "error product"
        }
    }
}
