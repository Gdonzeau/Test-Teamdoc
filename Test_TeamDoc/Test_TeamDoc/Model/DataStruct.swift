//
//  DataStruct.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 02/06/2022.
//

import Foundation

struct GeneralBase: Codable {
    let resource_version: Int
    let appVersion: [OS]
    let prefixes: [Prefix]
    let norm_Iso3166_2: [[String:Country]]
    var proStatus: [ProStatus]
    let speciality: [Speciality]
    // On adapte les noms pour qu'ils soient utilisable par Swift
    enum CodingKeys: String, CodingKey {
        case resource_version
        case appVersion = "application-version"
        case prefixes = "pn-prefix"
        case norm_Iso3166_2 = "iso-3166-2"
        case proStatus = "pro-status"
        case speciality
    }
}

struct OS: Codable {
    let os: String
    let intern: Int
    
    enum CodingKeys: String, CodingKey {
        case os
        case intern = "internal"
    }
}

struct Prefix: Codable {
    let iso2: String
    let iso3: String
    let prefix: String
}

struct Country: Codable {
    let name: String
    let divisions: [String: String]
}

struct ProStatus: Codable {
    let label: String
    var status: [Status]
}

struct Status: Codable {
    let key: String
    let external_key: Int?
    let label: String
    let abrev: String
    let status: Int
    let validate: Bool
    let network: Bool
    let role: String?
}

struct Speciality: Codable {
    let key: String
    let external_keys: [String]
    let label: String
    let abrev: String
    let sub: [SubSpeciality]?
}

struct SubSpeciality: Codable {
    let key: String
    let label: String
    let abrev: String
    let sub: [SousSubSpeciality]?
}

struct SousSubSpeciality: Codable {
    let key: String
    let label: String
    let abrev: String
    let sub: [UnderSpeciality]?
}

struct UnderSpeciality: Codable { // Rien car toutes les données sont nil
    
}


extension GeneralBase: Equatable {
    static func == (lhs: GeneralBase, rhs: GeneralBase) -> Bool {
        return // S'il y a autant de pays, de status et de spécialités dans les éléments comparés, on peut estimer qu'il n'y a pas eu de mise à jour.
            lhs.norm_Iso3166_2.count == rhs.norm_Iso3166_2.count &&
            lhs.proStatus.count == rhs.proStatus.count &&
            lhs.speciality.count == rhs.speciality.count
    }
}
