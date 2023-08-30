//
//  TextField.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 25.08.2023.
//

import UIKit

final class TextField: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    init(placeholder: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overriden Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    // MARK: - Private Methods
    private func setupTextField(placeholder: String) {
        textColor = .black
        layer.cornerRadius = 10
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.0

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 15, height: 15)

        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.cyan])
        font = .boldSystemFont(ofSize: 18)

        heightAnchor.constraint(equalToConstant: 60).isActive = true
        widthAnchor.constraint(equalToConstant: 220).isActive = true
    }

}
