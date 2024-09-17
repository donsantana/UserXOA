//
//  File.swift
//  
//
//  Created by Done Santana on 8/13/24.
//

import Foundation


extension String {
    var isNumeric: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }
}
