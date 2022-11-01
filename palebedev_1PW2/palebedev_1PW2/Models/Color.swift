//
//  Color.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 30.10.2022.
//

import UIKit

class Color: Codable {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    public var GetUIColor: UIColor{
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    init(_ color: UIColor){
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}
