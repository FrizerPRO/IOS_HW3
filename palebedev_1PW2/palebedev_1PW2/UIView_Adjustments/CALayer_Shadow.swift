//
//  CALayer_Shadow.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 02.10.2022.
//

import UIKit
extension CALayer{
    public func applyShadow(){
        shadowColor = UIColor.gray.cgColor
        shadowOffset = CGSize(width: 4,height: 4)
        shadowOpacity = 0.4
    }
}
