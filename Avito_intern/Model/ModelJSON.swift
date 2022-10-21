//
//  ModelJSON.swift
//  Avito_intern
//
//  Created by Егор Куракин on 18.10.2022.
//

// MARK: - Welcome
struct NameCompany: Codable {
    var company: Company
}

// MARK: - Company
struct Company: Codable {
    let name: String
    var employees: [Employee]
}

// MARK: - Employee
struct Employee: Codable {
    var name, phoneNumber: String
    let skills: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}

