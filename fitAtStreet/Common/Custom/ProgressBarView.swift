//
//  ProgressBarView.swift
//  fitAtStreet
//
//  Created by Ruslan Sadritdinov on 17.09.2023.


import UIKit

class ProgressBarView: UIView {

    private var gradientLayer = CAGradientLayer()
    private var progressBarLayer = CAShapeLayer()
    private var overlayLayer = CAShapeLayer()
    private var borderLayer = CAShapeLayer()

    var currentProgressState: ProgressState = .first

    var currentlength: CGFloat {
        switch currentProgressState {
        case .first:
            return 2 * .radius
        case .second:
            return 2 * .radius + .lineLength
        case .third:
            return 2 * .radius + 2 * .lineLength
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        // createAnimation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
        // createAnimation()
    }

    func setupLayers() {
        layer.addSublayer(gradientLayer)
        layer.addSublayer(progressBarLayer)
        layer.addSublayer(overlayLayer)
        layer.addSublayer(borderLayer)
    }

    override func draw(_ rect: CGRect) {

        let path = drawPath(rect)
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width, height: rect.height))
        let outerRect = UIBezierPath(rect: progressRect)

        path.append(outerRect)
        path.usesEvenOddFillRule = true

        progressBarLayer.frame = self.bounds
        progressBarLayer.path = path.cgPath
        progressBarLayer.fillRule = .evenOdd
        progressBarLayer.fillColor = UIColor.white.cgColor

        gradientLayer.frame = progressRect
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.colors = [UIColor.red.cgColor,  UIColor.yellow.cgColor, UIColor.green.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]

        let overlayRect = CGRect(x: currentlength, y: 0, width: rect.width - currentlength, height: rect.height)
        let overlayPath = UIBezierPath(rect: overlayRect)
        overlayLayer.fillColor = UIColor.white.cgColor
        overlayLayer.path = overlayPath.cgPath

        borderLayer.frame = self.bounds
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.path = drawPath(rect).cgPath
        borderLayer.lineWidth = 2
        borderLayer.strokeColor = UIColor.gray.cgColor

    }

    func drawPath(_ rect: CGRect) -> UIBezierPath {

        let progressBarPath = UIBezierPath()

        let startX = rect.origin.x + .radius
        let startY = rect.origin.y + .radius

        progressBarPath.move(to: CGPoint(x: startX - .radius, y: startY))

        progressBarPath.addArc(withCenter: CGPoint(x: startX, y: startY), radius: .radius, startAngle: CGFloat.pi, endAngle: 11*CGFloat.pi/6, clockwise: true)

        progressBarPath.addArc(withCenter: CGPoint(x: startX + .lineLength, y: startY), radius: .radius, startAngle: 7*CGFloat.pi/6, endAngle: 11*CGFloat.pi/6, clockwise: true)

        progressBarPath.addArc(withCenter: CGPoint(x: startX + 2 * .lineLength, y: startY), radius: .radius, startAngle: 7*CGFloat.pi/6, endAngle: 5*CGFloat.pi/6, clockwise: true)

        progressBarPath.addArc(withCenter: CGPoint(x: startX +  .lineLength, y: startY), radius: .radius, startAngle: CGFloat.pi/6, endAngle: 5*CGFloat.pi/6, clockwise: true)

        progressBarPath.addArc(withCenter: CGPoint(x: startX, y: startY), radius: .radius, startAngle: CGFloat.pi/6, endAngle: CGFloat.pi, clockwise: true)

        return progressBarPath
    }

    func setProgress(_ progress: ProgressState) {
        currentProgressState = progress
        setNeedsDisplay()
    }

//    private func createAnimation() {
//        let startPointAnimation = CAKeyframeAnimation(keyPath: "startPoint")
//        startPointAnimation.values = [CGPoint.zero, CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1)]
//
//        startPointAnimation.repeatCount = Float.infinity
//        startPointAnimation.duration = 1
//
//        let endPointAnimation = CAKeyframeAnimation(keyPath: "endPoint")
//        endPointAnimation.values = [CGPoint(x: 1, y: 1), CGPoint(x: 0, y: 1), CGPoint.zero]
//
//        endPointAnimation.repeatCount = Float.infinity
//        endPointAnimation.duration = 1
//
//        borderLayer.add(startPointAnimation, forKey: "startPointAnimation")
//        borderLayer.add(endPointAnimation, forKey: "endPointAnimation")
//
//    }

}

enum ProgressState {
    case first
    case second
    case third
}


private extension CGFloat {
    static let radius = 25.0
    static let lineLength: CGFloat = UIScreen.main.bounds.width / 3
}
