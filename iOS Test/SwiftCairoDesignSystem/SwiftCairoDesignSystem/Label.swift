//
//  Label.swift
//  SwiftCairoDesignSystem
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
import UIKit

public struct LabelViewModel {
    public init(text: String, weight: LabelViewModel.Weight, color: Color) {
        self.text = text
        self.weight = weight
        self.color = color
    }
    
    let text: String
    let weight: Weight
    let color: Color
    
    public enum Weight {
        case normal, bold
    }
}
