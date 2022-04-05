//
//  String.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 4/4/22.
//

import Foundation

extension String {
    func removeWhitespaceUnicode() -> String {
        return self.replacingOccurrences(of: "\\s", with: " ", options: .regularExpression)
    }
}
