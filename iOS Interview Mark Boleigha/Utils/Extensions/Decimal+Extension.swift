//
//  Decimal+Extension.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Mark Boleigha. All rights reserved.
//

import Foundation

extension Decimal {
    var formattedAmount: String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: self as NSDecimalNumber)
    }
}
