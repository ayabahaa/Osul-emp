//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileModel = try? newJSONDecoder().decode(ProfileModel.self, from: jsonData)

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    let status: Int?
    let msg, arMsg: String?
    let data: [ProfileModelDatum]?

    enum CodingKeys: String, CodingKey {
        case status, msg
        case arMsg = "ar_msg"
        case data
    }
}

// MARK: - Datum
struct ProfileModelDatum: Codable {
    let id, name, email, phone: String?
    let password, jopType, usersGroup, date: String?
    let branche, state, address, refCode: String?
    let isActive, firebaseType, tokenID, msg: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, password
        case jopType = "jop_type"
        case usersGroup = "users_group"
        case date, branche, state, address
        case refCode = "ref_code"
        case isActive = "is_active"
        case firebaseType = "firebase_type"
        case tokenID = "token_id"
        case msg
    }
}
