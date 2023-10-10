//
//  UIColor+Brightness.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 11.09.2023.
//

import UIKit

extension UIColor {

    public var brightness: CGFloat {
        let components = self.components
        let value =
            0.2126 * components.r +
            0.7152 * components.g +
            0.0722 * components.b
        return value
    }

    public static func contrast(between color1: UIColor, and color2: UIColor) -> CGFloat {
        let lighter = max(color1.brightness, color2.brightness)
        let darker = min(color1.brightness, color2.brightness)
        let value = (lighter + 0.05) / (darker + 0.05)
        return value
    }
}

extension UIColor {
    private var components: Components {
        let color = CIColor(color: self)
        return Components(a: color.alpha, r: color.red, g: color.green, b: color.blue)
    }

    private struct Components {
        let a: CGFloat
        let r, g, b: CGFloat

        var luminatedComponents: Components {
            return Components(a: conditional(for: a),
                              r: conditional(for: r),
                              g: conditional(for: g),
                              b: conditional(for: b))
        }

        private func conditional(for value: CGFloat) -> CGFloat {
            if value <= 0.03928 {
                return value / 12.92
            }
            return pow((value + 0.055) / 1.055, 2.4)
        }
    }
}
