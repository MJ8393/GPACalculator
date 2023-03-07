//
//  Ext+UserDefaults.swift
//  GPACalculator
//
//  Created by Mekhriddin Jumaev on 08/03/23.
//

import Foundation

let UD = UserDefaults(suiteName: "gpaCalculator")!

extension UserDefaults {
    var isUzbek: Bool {
        get { return self.bool(forKey: "language")}
        set { self.set(newValue, forKey: "language")}
    }
}
