//
//  ConstantsData.swift
//  AL-HHALIL
//
//  Created by Sayed Abdo on 7/14/20.
//  Copyright © 2020 Sayed Abdo. All rights reserved.
//


import Foundation
import UIKit
public struct ConstantsPdfData {
    public static let plusLineWidth: CGFloat = 3.0
    public static let plusButtonScale: CGFloat = 0.6
    public static let halfPointShift: CGFloat = 0.5
    public static let cornerRadii: CGSize = CGSize(width: 25, height: 25)
    public static let arrowWidth: CGFloat = 8
    public static let radii: CGFloat = 50
    static var lineWidth: CGFloat = 5
    static let opacity: Float = 0.25
    static let defaultPoint: CGPoint = CGPoint(x: -5, y: -5)
}

enum DrawingTypes{
    case draw
    case highlight
    case lasso
    case text
    case erase
}

public enum DrawingStyle {
    case vertical
    case horizontal
}
