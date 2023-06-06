//
//  Color.swift
//  SwiftCairoDesignSystem
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
import UIKit

public enum Color {
    case black
}

extension Color {
    var uiColor: UIColor {
        switch self {
        case .black:
            return .black
        }
    }
}
