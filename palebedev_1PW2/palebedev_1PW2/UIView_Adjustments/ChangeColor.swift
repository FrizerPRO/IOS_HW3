//
//  ChangeColor.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 01.11.2022.
//

import UIKit

extension UIButton:ChangeTextColorProtocol,ChangeBorderColorProtocol,ChangeSecondColorProtocol{
    func ChangeBorderColor(color: UIColor) {
        layer.borderColor = color.cgColor
    }
    
    func ChangeSecondColor(color: UIColor) {
        backgroundColor = color
    }
    
    func ChangeTextColor(color: UIColor) {
        setTitleColor(color, for: .normal)
    }
}
extension UILabel:ChangeTextColorProtocol{
    func ChangeTextColor(color: UIColor) {
        textColor = color
    }
}
extension ColorPaletteView: ChangeSecondColorProtocol, ChangeBorderColorProtocol, ChangeBackgroundColorProtocol{
    func ChangeSecondColor(color: UIColor) {
        ChangeStackColor(color: color)
    }
    func ChangeBorderColor(color: UIColor) {
        ChangeStrokeColor(color: color)
    }
    func ChangeBackgroundColor(color: UIColor) {
        superview?.backgroundColor = color
        chosenColor = color
    }
}
