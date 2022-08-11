//
//  ExplanationDetails.swift
//  AL-HHALIL
//
//  Created by Sayed Abdo on 8/16/20.
//  Copyright © 2020 Sayed Abdo. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ExplanationDetails: Codable {
    let status: Int
    let msg, arMsg: String
    let data: ExplanationDetailsDatum

    enum CodingKeys: String, CodingKey {
        case status, msg
        case arMsg = "ar_msg"
        case data
    }
}

// MARK: - DataClass
struct ExplanationDetailsDatum: Codable {
    let id, title, comments, date: String
    let time, empID, empName, projectID: String

    enum CodingKeys: String, CodingKey {
        case id, title, comments, date, time
        case empID = "emp_id"
        case empName = "emp_name"
        case projectID = "project_id"
    }
}
