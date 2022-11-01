//
//  ColorPaletteView.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 18.10.2022.
//

import UIKit

final class ColorPaletteView: UIControl {
    private let stackView = UIStackView()
    private(set) var chosenColorPrivate: UIColor = .systemGray6
    var chosenColor: UIColor {
        get{
            return chosenColorPrivate
        }
        set{
            chosenColorPrivate = newValue
            while(!stackView.arrangedSubviews.isEmpty){
                let cell = stackView.arrangedSubviews[0]
                cell.removeFromSuperview()
                stackView.removeArrangedSubview(cell)
            }
            initBackground()
        }
    }
    init() {
        super.init(frame: .zero)
        //setupView()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func initBackground(){
        chosenColorPrivate = superview?.backgroundColor ?? .red
        setupView()
    }
    private func setupView() {
        let redControl = ColorSliderView(colorName: "R", value:
                                            Float(chosenColor.redComponent))
        let greenControl = ColorSliderView(colorName: "G", value:
                                            Float(chosenColor.greenComponent))
        let blueControl = ColorSliderView(colorName: "B", value:
                                            Float(chosenColor.blueComponent))
        redControl.tag = 0
        greenControl.tag = 1
        blueControl.tag = 2
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redControl)
        stackView.addArrangedSubview(greenControl)
        stackView.addArrangedSubview(blueControl)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 12
        stackView.layer.applyShadow()
        [redControl, greenControl, blueControl].forEach{
            $0.addTarget(self, action: #selector(sliderMoved(slider:)),
                         for: .touchDragInside)
        }
        addSubview(stackView)
        stackView.pin(to: self)
    }
    public func ChangeStrokeColor(color: UIColor){
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = color.cgColor
    }
    
    public func ChangeStackColor(color: UIColor){
        stackView.backgroundColor = color
    }
    
    @objc
    private func sliderMoved(slider: ColorSliderView) {
        switch slider.tag {
        case 0:
            self.chosenColorPrivate = UIColor(
                red: CGFloat(slider.value),
                green: chosenColor.greenComponent, blue: chosenColor.blueComponent, alpha: chosenColor.alphaComponent
            )
        case 1:
            self.chosenColorPrivate = UIColor(
                red: chosenColor.redComponent, green: CGFloat(slider.value), blue: chosenColor.blueComponent, alpha: chosenColor.alphaComponent
            )
        default:
            self.chosenColorPrivate = UIColor(
                red: chosenColor.redComponent, green: chosenColor.greenComponent, blue: CGFloat(slider.value), alpha: chosenColor.alphaComponent
            )
        }
        sendActions(for: .touchDragInside)
    }
}
extension ColorPaletteView {
    private final class ColorSliderView: UIControl {
        private var slider = UISlider()
        private let colorLabel = UILabel()
        
        private(set) var value: Float
        
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)
            slider.value = value
            colorLabel.text = colorName
            setupView()
            slider.addTarget(self, action:
                                #selector(sliderMoved(_:)), for: .touchDragInside)
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews:
                                            [colorLabel, slider])
            stackView.axis = .horizontal
            
            stackView.spacing = 8
            addSubview(stackView)
            stackView.pin(to: self, [.left: 12, .top: 12, .right:12, .bottom: 12])
        }
        
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
    }
}
