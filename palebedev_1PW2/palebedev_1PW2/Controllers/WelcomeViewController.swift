//
//  WelcomeViewController.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 02.10.2022.
//

import UIKit

final class WelcomeViewController: UIViewController{
    /**Label with achievments.*/
    private let commentLabel = UILabel()
    /**Label with value.*/
    private let valueLabel = UILabel()
    /**Value it self*/
    private var value: Int = 0
    /**Button that increments value*/
    private let incrementButton = UIButton();
    /**View with a comment**/
    private let commentView = UIView()
    /*Palette that changes background color**/
    let colorPaletteView = ColorPaletteView()
    var buttonsSV = UIStackView()
    var themePicker: ThemePickerViewController = ThemePickerViewController()
    var colorTheme: ColorTheme = ColorTheme(backgroundColor: .systemGray6, strokeColor: .black, secondColor: .white, textColor: .black)

    
    //С помощью это штуки вы можете выбрать тему приложения. ЧТобы добавить свою - закиньте свой файл в формате json в папку AppData в формаье тех файлов, которые уже там лежат. Назнание файла = название темы
    
    private func setupThemePicker(){
        themePicker.viewDidLoad()
        themePicker.setupThemePicker(colorTheme: colorTheme)
        view.addSubview(themePicker.pickerView)
        themePicker.pickerView.pinTop(to: commentView.bottomAnchor, 10)
        themePicker.pickerView.pinCenterX(to: view.centerXAnchor)
        themePicker.pickerView.setHeight(50)
    }
    
    /**Creates increment button and sets coordinates*/
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        colorTheme.AddView(view: incrementButton)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize:16.0, weight: .medium)
        incrementButton.layer.borderWidth = 1
        incrementButton.layer.applyShadow()
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action:
                                    #selector(incrementButtonPressed), for: .touchUpInside)
    }
    /**Creates valur label and sets coordinates*/
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0,
                                      weight: .bold)
        colorTheme.AddView(view: valueLabel)
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenterX(to: self.view.centerXAnchor)
    }
    private func setupView() {
        view.backgroundColor = colorTheme.backgroundColor
        colorPaletteView.isHidden = true
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
    }
    /**if button is pushed*/
    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
    }
    /**Updates label and value with animation.*/
    func updateUI(){
        //Renew value
        UIView.transition(with: valueLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [self] in
            self.valueLabel.text = "\(self.value)"
        }, completion: nil)
        //Renew label
        UIView.transition(with: commentLabel,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { [self] in
            self.updateCommentLabel(value: value)
        }, completion: nil)
        
    }
    
    /**If palette button is pressed we enable color change fuctionality*/
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    @objc
    private func notesButtonPressed() {
        let notesViewController = NotesViewController()
        notesViewController.modalPresentationStyle = .overCurrentContext
        let navCont = UINavigationController(rootViewController: notesViewController)
        present(navCont, animated: true)
    }
    /**animation of color change*/
    @objc
    private func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {[self] in
            self.view.backgroundColor = slider.chosenColor
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupThemePicker()
        
    }

    /**Creates comment view and sets coordinates*/
    private func setupCommentView() {
        colorTheme.AddView(view: commentView)
        commentView.layer.cornerRadius = 12
        commentView.layer.borderWidth = 1
        view.addSubview(commentView)
        commentView.pinTop(to:
                            self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0,
                                        weight: .regular)
        commentLabel.numberOfLines = 0
        colorTheme.AddView(view: commentLabel)
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top:16, .left:16, .bottom:16, .right:16])
    }
    /*updates comment view*/
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    /// creates Menu button with title
    ///  - Parameter title: title to be set as button title
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0,
                                              weight: .medium)
        button.layer.applyShadow()
        colorTheme.AddView(view: button)
        button.layer.borderWidth = 1
        button.heightAnchor.constraint(equalTo:
                                        button.widthAnchor).isActive = true
        return button
    }
    
    /**Sets all menu buttons*/
    private func setupMenuButtons() {
        /**Color button**/
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(self, action:
                                #selector(paletteButtonPressed), for: .touchUpInside)
        colorTheme.AddView(view: colorsButton)
        /**Notes Button**/
        let notesButton = makeMenuButton(title: "📝")
        notesButton.addTarget(self, action:
                                #selector(notesButtonPressed), for: .touchUpInside)

        colorTheme.AddView(view: notesButton)
        
        /**News button**/
        let newsButton = makeMenuButton(title: "📰")
        newsButton.addTarget(self, action: #selector(newsButtonPressed), for: .touchUpInside)
        colorTheme.AddView(view: newsButton)
        
        
        buttonsSV = UIStackView(arrangedSubviews:
                                    [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonsSV.pinBottom(to:
                                self.view.safeAreaLayoutGuide.bottomAnchor, 24)
        
    }
    @objc
    private func newsButtonPressed() {
    let newsListController = NewsListViewController()
    navigationController?.pushViewController(newsListController, animated: true)
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        colorPaletteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
        view.addSubview(colorPaletteView)
        colorPaletteView.initBackground()
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo:
                                                    incrementButton.bottomAnchor, constant: 8),
            colorPaletteView.leadingAnchor.constraint(equalTo:
                                                        view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPaletteView.trailingAnchor.constraint(equalTo:
                                                        view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo:
                                                        buttonsSV.topAnchor, constant: -8)
        ])
        colorTheme.AddView(view: colorPaletteView)
        colorTheme.Copy(from: ColorTheme())
    }
}
