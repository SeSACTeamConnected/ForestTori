//
//  Colors.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/08/23.
//

import SwiftUI

extension Color {
    enum STRColors: strColors {
        case strBlack
        case strBrown
        case strGreen
        case strRed
        case strWhite
        
        var color: Color {
            switch self {
            case .strBlack:
                return Color("STR_Black")
            case .strBrown:
                return Color("STR_Brown")
            case .strGreen:
                return Color("STR_Green")
            case .strRed:
                return Color("STR_Red")
            case .strWhite:
                return Color("STR_White")
            }
        }
    }
}

protocol strColors {
    var color: Color { get }
}
