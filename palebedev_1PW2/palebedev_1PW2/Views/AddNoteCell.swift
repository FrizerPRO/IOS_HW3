//
//  AddNodeCell.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 13.11.2022.
//

import UIKit

class AddNoteCell: UITableViewCell,UITextViewDelegate {
    private var defaultText = "Введите текст"
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    public var addButton = UIButton()
    public var delegate: AddNoteDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView(){
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.text = defaultText
        textView.backgroundColor = .clear
        textView.setHeight(140)
        textView.delegate = self
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .label
        addButton.layer.cornerRadius = 8
        addButton.setHeight(44)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.isEnabled = false
        addButton.alpha = 0.5
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
            // Do something
        if textView.text == defaultText {
                textView.text = ""
                addButton.isEnabled = true
            }
            return true
        }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = defaultText
            addButton.isEnabled = false
        }
    }
    @objc
    private func addButtonTapped(){
        if let delegate = delegate, textView.text != ""{
            delegate.newNoteAdded(note: ShortNote(text: textView.text))
        }
        textView.text = defaultText
        addButton.isEnabled = false
    }
}
