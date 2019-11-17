//
//  ProgressStyle.swift
//  assignment
//
//  Created by I0006 on 14/11/19.
//  Copyright © 2019 I0006. All rights reserved.
//

import GradientCircularProgress
import CoreGraphics

public struct ProgressStyle: StyleProperty {

    // Progress Size
    public var progressSize: CGFloat = 60

    // Gradient Circular
    public var arcLineWidth: CGFloat = 4.0
    public var startArcColor: UIColor = ColorUtil.toUIColor(r: 0.0, g: 122.0, b: 255.0, a: 1.0)
    public var endArcColor: UIColor = UIColor.cyan

    // Base Circular
    public var baseLineWidth: CGFloat? = 6.0
    public var baseArcColor: UIColor? = UIColor(red:0.5, green: 0.5, blue: 0.0, alpha: 0.5)

    // Ratio
    public var ratioLabelFont: UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var ratioLabelFontColor: UIColor? = UIColor.clear

    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var messageLabelFontColor: UIColor? = UIColor.black

    // Background
    public var backgroundStyle: BackgroundStyles = .transparent

    // Dismiss
    public var dismissTimeInterval: Double? = nil // 'nil' for default setting.

    /*** style properties **********************************************************************************/

    public init() {}
}
