//
//  Service.swift
//  Services
//
//  Created by leila on 19.06.2022.
//

import Foundation


struct GroupData: Decodable {
    let data: [Group]
}

struct Group: Decodable {
    let id: Int
    let name: String
    let description: String
}

struct ServiceData: Decodable {
    let data: [Service]
    let meta: ServiceMeta
}

struct ServiceMeta: Decodable {
    let page: Int
    let pages: Int
}

struct Service: Decodable {
    let id: Int
    let serviceGroupId: Int
    let name: String
    let price: Double
    let currency: String
    let duration: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case serviceGroupId = "service_group_id"
        case name = "name"
        case price = "price"
        case currency = "currency"
        case duration = "duration"
    }
}

struct EmployeeData: Decodable {
    let data: [Employee]
    let meta: EmployeeMeta
}

struct EmployeeMeta: Decodable {
    let page: Int
    let pages: Int
}

struct Employee: Decodable {
    let id: Int
    let firstName: String
    let lastName: String?
    let imageUrl: String?
    let position: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "photo"
        case position = "position"
    }
}

enum Link: String {
    case groupURL = "https://business-beauty.staging.eservia.com/api/v1.0/widget/service-groups?sort=-id&code=35CDFF1D10A64E9E91D4EA9C8B983DBC"
    case serviceURL = "https://business-beauty.staging.eservia.com/api/v1.0/widget/services?code=35CDFF1D10A64E9E91D4EA9C8B983DBC"
    case employeeURL = "https://business-beauty.staging.eservia.com/api/v1.0/widget/staffs?code=35CDFF1D10A64E9E91D4EA9C8B983DBC"
}

