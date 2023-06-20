//
//  ProductInfoModel.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import Foundation

// MARK: - ProductInfoModel
struct ProductInfoModel: Codable {
    let code: Double?
    let body: Body?
}

// MARK: - Body
struct Body: Codable {
    let id: String
    let siteID, title: String?
    let sellerID: Int?
    let categoryID: String?
    let price, basePrice: Double?
    let currencyID: String?
    let initialQuantity, availableQuantity, soldQuantity: Int?
    let saleTerms: [SaleTerm]?
    let buyingMode, listingTypeID, startTime, stopTime: String?
    let condition: String?
    let permalink: String?
    let thumbnailID: String?
    let thumbnail: String?
    let secureThumbnail: String?
    let pictures: [Picture]?
    let acceptsMercadopago: Bool?
    let shipping: Shipping?
    let internationalDeliveryMode: String?
    let sellerAddress: SellerAddress?
    let attributes: [Attribute]?
    let listingSource: String?
    let status: String?
    let tags: [String]?
    let warranty, catalogProductID, domainID: String?
    let automaticRelist: Bool?
    let dateCreated, lastUpdated: String?
    let catalogListing: Bool?
    let channels: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title
        case sellerID = "seller_id"
        case categoryID = "category_id"
        case price
        case basePrice = "base_price"
        case currencyID = "currency_id"
        case initialQuantity = "initial_quantity"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case saleTerms = "sale_terms"
        case buyingMode = "buying_mode"
        case listingTypeID = "listing_type_id"
        case startTime = "start_time"
        case stopTime = "stop_time"
        case condition, permalink
        case thumbnailID = "thumbnail_id"
        case thumbnail
        case secureThumbnail = "secure_thumbnail"
        case pictures
        case acceptsMercadopago = "accepts_mercadopago"
        case shipping
        case internationalDeliveryMode = "international_delivery_mode"
        case sellerAddress = "seller_address"
        case attributes
        case listingSource = "listing_source"
        case status
        case tags, warranty
        case catalogProductID = "catalog_product_id"
        case domainID = "domain_id"
        case automaticRelist = "automatic_relist"
        case dateCreated = "date_created"
        case lastUpdated = "last_updated"
        case catalogListing = "catalog_listing"
        case channels
    }
}

// MARK: - Value
struct Value: Codable {
    let id: String?
    let name: String?
    let valueStruct: Struct?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueStruct = "struct"
    }
}

// MARK: - Picture
struct Picture: Codable {
    let id: String?
    let url: String?
    let secureURL: String?
    let size, maxSize, quality: String?

    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
        case size
        case maxSize = "max_size"
        case quality
    }
}

// MARK: - SaleTerm
struct SaleTerm: Codable {
    let id, name, valueID, valueName: String?
    let values: [Value]?
    let valueType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case values
        case valueType = "value_type"
    }
}

// MARK: - City
struct City: Codable {
    let id, name: String?
}

// MARK: - SearchLocation
struct SearchLocation: Codable {
    let neighborhood, city, state: City?
}
