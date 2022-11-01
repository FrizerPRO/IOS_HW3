//
//  File.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 19.10.2022.
//

import UIKit
extension UIColor{
    private var getRgb: (CGFloat,CGFloat,CGFloat,CGFloat){
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red,green,blue,alpha)
    }
    public var redComponent :CGFloat {
        return getRgb.0
    }
    public var greenComponent :CGFloat {
        return getRgb.1
    }
    public var blueComponent :CGFloat {
        return getRgb.2
    }
    public var alphaComponent :CGFloat {
        return getRgb.3
    }
}
