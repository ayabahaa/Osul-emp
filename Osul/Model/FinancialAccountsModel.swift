//
//  FinancialAccountsModel.swift
//  AL-HHALIL
//
//  Created by Sayed Abdo && Aya Bahaa on 7/3/20.
//  Copyright © 2020 Sayed Abdo. All rights reserved.
//

import UIKit
class FinancialAccounts : NSObject{
    var imageName = ""
    var departmentName  = ""
    
    init(imageName : String , departmentName : String ){
        self.imageName = imageName
        self.departmentName = departmentName
    }
}
