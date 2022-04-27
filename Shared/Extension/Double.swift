//
//  Double.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/24/22.
//

import Foundation

extension Double {
    func removeTrailingZeroes() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = (self.description.components(separatedBy: ".").last)!.count
        return String(formatter.string(from: number) ?? "")
    }
}
