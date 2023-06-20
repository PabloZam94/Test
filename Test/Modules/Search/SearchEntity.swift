//
//  SearchModel.swift
//  Test
//
//  Created by pablo luis velazquez zamudio on 19/06/23.
//

import Foundation

// MARK: - Search
struct SearchModel: Codable {
    let siteID: String?
    let countryDefaultTimeZone, query: String?
    let paging: Paging?
    let results: [Result]?
    let sort: Sort?
    let availableSorts: [Sort]?
    let filters: [Filter]?
    let availableFilters: [AvailableFilter]?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case query, paging, results, sort//, sort
        case availableSorts = "available_sorts"
        case filters
        case availableFilters = "available_filters"
    }
}

// MARK: - AvailableFilter
struct AvailableFilter: Codable {
    let id, name: String?
    let type: String?
    let values: [AvailableFilterValue]?
}

enum TypeEnum: String, Codable {
    case boolean = "boolean"
    case list = "list"
    case range = "range"
    case string = "STRING"
    case text = "text"
}

// MARK: - AvailableFilterValue
struct AvailableFilterValue: Codable {
    let id, name: String?
    let results: Int?
}

// MARK: - Sort
struct Sort: Codable {
    let id, name: String?
}

// MARK: - Filter
struct Filter: Codable {
    let id, name: String?
    let type: TypeEnum?
    let values: [FilterValue]?
}

// MARK: - FilterValue
struct FilterValue: Codable {
    let id, name: String?
    let pathFromRoot: [Sort]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case pathFromRoot = "path_from_root"
    }
}

// MARK: - Paging
struct Paging: Codable {
    let total, primaryResults, offset, limit: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset, limit
    }
}

// MARK: - Result
struct Result: Codable {
    let id, title: String?
    let condition: String?
    let thumbnailID, catalogProductID: String?
    let listingTypeID: String?
    let permalink: String?
    let buyingMode: String?
    let siteID: String?
    let categoryID: String?
    let domainID: String?
    let thumbnail: String?
    let currencyID: String?
    let orderBackend, price: Double?
    let soldQuantity, availableQuantity: Int?
    let useThumbnailID, acceptsMercadopago: Bool?
    let tags: [String]?
    let shipping: Shipping?
    let stopTime: String?
    let seller: Seller?
    let sellerAddress: SellerAddress?
    let address: Address?
    let attributes: [Attribute]?
    let installments: Installments?
    let catalogListing: Bool?
    let differentialPricing: DifferentialPricing?
    let variationID: String?
    let variationFilters: [String]?

    enum CodingKeys: String, CodingKey {
        case id, title, condition
        case thumbnailID = "thumbnail_id"
        case catalogProductID = "catalog_product_id"
        case listingTypeID = "listing_type_id"
        case permalink
        case buyingMode = "buying_mode"
        case siteID = "site_id"
        case categoryID = "category_id"
        case domainID = "domain_id"
        case thumbnail
        case currencyID = "currency_id"
        case orderBackend = "order_backend"
        case price
        case soldQuantity = "sold_quantity"
        case availableQuantity = "available_quantity"
        case useThumbnailID = "use_thumbnail_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case tags, shipping
        case stopTime = "stop_time"
        case seller
        case sellerAddress = "seller_address"
        case address, attributes, installments
        case catalogListing = "catalog_listing"
        case differentialPricing = "differential_pricing"
        case variationID = "variation_id"
        case variationFilters = "variation_filters"
    }
}

// MARK: - Address
struct Address: Codable {
    let stateID, stateName, cityID, cityName: String?

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
    }
}

// MARK: - Attribute
struct Attribute: Codable {
    let id: String?
    let name: String?
    let valueID: String?
    let valueName: String?
    let attributeGroupID: String?
    let attributeGroupName: String?
    let valueStruct: Struct?
    let source: Int?
    let valueType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case valueStruct = "value_struct"
        case source
        case valueType = "value_type"
    }
}

// MARK: - Struct
struct Struct: Codable {
    let number: Double?
    let unit: String?
}

// MARK: - AttributeValue
struct AttributeValue: Codable {
    let id: String?
    let name: String?
    let valueStruct: Struct?
    let source: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueStruct = "struct"
        case source
    }
}

// MARK: - DifferentialPricing
struct DifferentialPricing: Codable {
    let id: Int?
}

// MARK: - Installments
struct Installments: Codable {
    let quantity: Int?
    let amount, rate: Double?
    let currencyID: String?

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}

// MARK: - Seller
struct Seller: Codable {
    let id: Int?
    let nickname: String?
    let carDealer, realEstateAgency, empty: Bool?
    let registrationDate: String?
    let tags: [String]?
    let carDealerLogo: String?
    let permalink: String?
    let sellerReputation: SellerReputation?
    let eshop: Eshop?

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
        case empty = "_"
        case registrationDate = "registration_date"
        case tags
        case carDealerLogo = "car_dealer_logo"
        case permalink
        case sellerReputation = "seller_reputation"
        case eshop
    }
}

// MARK: - Eshop
struct Eshop: Codable {
    let eshopID, seller: Int?
    let nickName: String?
    let eshopStatusID: Int?
    let siteID: String?
    let eshopExperience: Int?
    let eshopLogoURL: String?

    enum CodingKeys: String, CodingKey {
        case eshopID = "eshop_id"
        case seller
        case nickName = "nick_name"
        case eshopStatusID = "eshop_status_id"
        case siteID = "site_id"
        case eshopExperience = "eshop_experience"
        case eshopLogoURL = "eshop_logo_url"
    }
}

// MARK: - SellerReputation
struct SellerReputation: Codable {
    let levelID: String?
    let powerSellerStatus: String?
    let transactions: Transactions?
    let metrics: Metrics?

    enum CodingKeys: String, CodingKey {
        case levelID = "level_id"
        case powerSellerStatus = "power_seller_status"
        case transactions, metrics
    }
}

// MARK: - Metrics
struct Metrics: Codable {
    let sales: Sales?
    let claims, delayedHandlingTime, cancellations: Cancellations?

    enum CodingKeys: String, CodingKey {
        case sales, claims
        case delayedHandlingTime = "delayed_handling_time"
        case cancellations
    }
}

// MARK: - Cancellations
struct Cancellations: Codable {
    let period: String?
    let rate: Double?
    let value: Int?
    let excluded: Excluded?
}

// MARK: - Excluded
struct Excluded: Codable {
    let realValue: Int?
    let realRate: Double?

    enum CodingKeys: String, CodingKey {
        case realValue = "real_value"
        case realRate = "real_rate"
    }
}

// MARK: - Sales
struct Sales: Codable {
    let period: String?
    let completed: Int?
}

// MARK: - Transactions
struct Transactions: Codable {
    let canceled, completed: Int?
    let period: String?
    let ratings: Ratings?
    let total: Int?
}

// MARK: - Ratings
struct Ratings: Codable {
    let negative, neutral, positive: Double?
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
    let comment, addressLine: String?
    let country, state, city: Sort?

    enum CodingKeys: String, CodingKey {
        case comment
        case addressLine = "address_line"
        case country, state, city
    }
}

// MARK: - Shipping
struct Shipping: Codable {
    let storePickUp, freeShipping: Bool?
    let logisticType: String?
    let mode: String?
    let tags: [String]?
    let promise: String?

    enum CodingKeys: String, CodingKey {
        case storePickUp = "store_pick_up"
        case freeShipping = "free_shipping"
        case logisticType = "logistic_type"
        case mode, tags, promise
    }
}

// MARK: - VariationsDatum
struct VariationsDatum: Codable {
    let thumbnail: String?
    let ratio, name: String?
    let picturesQty: Int?

    enum CodingKeys: String, CodingKey {
        case thumbnail, ratio, name
        case picturesQty = "pictures_qty"
    }
}
