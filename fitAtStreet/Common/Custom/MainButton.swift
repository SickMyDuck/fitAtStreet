//
//  MainButton.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 25.08.2023.
//

import UIKit

final class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Section
private extension MainButton {
    func setup() {
        setupStyle()
        setupShadow()
    }

    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: .small, height: .small)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.4
        clipsToBounds = true
        layer.masksToBounds = false
    }

    func setupStyle() {
        setTitleColor(.white, for: .normal)

        backgroundColor = .systemBlue
        titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        layer.cornerRadius = .medium

    }
}

// MARK: - Action Section
extension MainButton {
    func shake() {

        Vibration.error.vibrate()
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true

        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue

        layer.add(shake, forKey: "position")
    }

    func tap() {

        Vibration.success.vibrate()

        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations:  {
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 4, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            } , completion: nil)
        }
    }
}
