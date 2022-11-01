//
//  ColorTheme.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 30.10.2022.
//

import UIKit

class ColorTheme: Codable{
    enum CodingKeys: String, CodingKey {
        case backgroundColor
        case strokeColor
        case secondColor
        case textColor
    }
    
    private var backgroundColorPrivate = UIColor()
    private var strokeColorPrivate = UIColor()
    private var secondColorPrivate = UIColor()
    private var textColorPrivate = UIColor()
    private var allViews = [UIView]()
    
    var backgroundColor : UIColor{
        get{
            return backgroundColorPrivate
        }
        set{
            backgroundColorPrivate = newValue
            for cell in allViews{
                if let cell = cell as? ChangeBackgroundColorProtocol{
                    cell.ChangeBackgroundColor(color: newValue)
                }
            }
        }
    }
    var strokeColor : UIColor{
        get{
            return strokeColorPrivate
        }
        set{
            strokeColorPrivate = newValue
            for cell in allViews{
                if let cell = cell as? ChangeBorderColorProtocol {
                    cell.ChangeBorderColor(color: newValue)
                }
            }
        }
    }
    var secondColor : UIColor{
        get{
            return secondColorPrivate
        }
        set{
            secondColorPrivate = newValue
            for cell in allViews{
                if let cell = cell as? ChangeSecondColorProtocol {
                    cell.ChangeSecondColor(color: newValue)
                }
            }
        }
    }
    var textColor : UIColor{
        get{
            return textColorPrivate
        }
        set{
            textColorPrivate = newValue
            for cell in allViews{
                if let cell = cell as? ChangeTextColorProtocol {
                    cell.ChangeTextColor(color: newValue)
                }
            }
        }
    }
    public func AddView(view: UIView){
        allViews.append(view)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Color(backgroundColor),forKey: .backgroundColor)
        try container.encode(Color(strokeColor),forKey: .strokeColor)
        try container.encode(Color(secondColor),forKey: .secondColor)
        try container.encode(Color(textColor),forKey: .textColor)
        
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backgroundColor = try container.decode(Color.self, forKey: .backgroundColor).GetUIColor
        strokeColor = try container.decode(Color.self, forKey: .strokeColor).GetUIColor
        secondColor = try container.decode(Color.self, forKey: .secondColor).GetUIColor
        textColor = try container.decode(Color.self, forKey: .textColor).GetUIColor
        
    }
    public init(  backgroundColor: UIColor,
                  strokeColor: UIColor,
                  secondColor: UIColor,
                  textColor : UIColor
    ){
        self.backgroundColor = backgroundColor
        self.strokeColor = strokeColor
        self.secondColor = secondColor
        self.textColor = textColor
    }
    public init(){
        self.backgroundColor = .systemGray6
        self.strokeColor = .black
        self.secondColor = .white
        self.textColor = .black
    }
    public func Copy(from copy: ColorTheme){
        self.backgroundColor = copy.backgroundColor
        self.strokeColor = copy.strokeColor
        self.secondColor = copy.secondColor
        self.textColor = copy.textColor
    }
}
