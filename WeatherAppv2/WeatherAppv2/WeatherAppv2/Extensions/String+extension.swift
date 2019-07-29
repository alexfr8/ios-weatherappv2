//
//  String+extension.swift
//  WeatherAppv2
//
//  Created by Alejandro Fernández Ruiz on 29/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

import Foundation

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
