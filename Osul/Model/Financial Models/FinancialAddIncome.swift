//
//  FinancialAddIncome.swift
//  AL-HHALIL
//
//  Created by Sayed Abdo on 9/14/20.
//  Copyright © 2020 Sayed Abdo. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct FinancialAddIncome: Codable {
    let status: Int
    let msg, arMsg: String
    let data: FinancialAddIncomeDataClass

    enum CodingKeys: String, CodingKey {
        case status, msg
        case arMsg = "ar_msg"
        case data
    }
}

// MARK: - DataClass
struct FinancialAddIncomeDataClass: Codable {
    let id, projectID, projectName, date: String
    let amount, details, type: String

    enum CodingKeys: String, CodingKey {
        case id
        case projectID = "project_id"
        case projectName = "project_name"
        case date, amount, details, type
    }
}
