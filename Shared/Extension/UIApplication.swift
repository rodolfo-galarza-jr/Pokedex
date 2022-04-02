//
//  UIApplication.swift
//  Pokedex (iOS)
//
//  Created by Rodolfo Galarza Jr on 3/17/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
