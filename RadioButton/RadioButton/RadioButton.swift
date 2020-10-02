//
//  RadioButton.swift
//  RadioButton
//
//  Created by Emil Abduselimov on 02.10.2020.
//

import UIKit

class RadioButton: UIControl {

    var isOn = false {
        didSet {
            sendActions(for: .valueChanged)
            updateSublayers()
        }
    }

    var onTintColor: UIColor = .seafoamBlue

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 20, height: 20)
    }

    private let borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.strokeColor = UIColor.silver.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()

    private let fillCircleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configure()
    }

    // MARK: - Update

    private func updateSublayers() {
        borderLayer.strokeColor = isOn ? onTintColor.cgColor : UIColor.silver.cgColor
        fillCircleLayer.fillColor = isOn ? onTintColor.cgColor : UIColor.clear.cgColor
    }

    // MARK: - Configuration

    private func configure() {
        backgroundColor = .white
        borderLayer.contentsScale = contentScaleFactor
        fillCircleLayer.contentsScale = contentScaleFactor
        layer.addSublayer(borderLayer)
        layer.addSublayer(fillCircleLayer)
        updateSublayers()
    }

    // MARK: - Layout

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        borderLayer.frame = layer.bounds
        borderLayer.path = UIBezierPath(ovalIn: borderLayer.bounds).cgPath
        fillCircleLayer.frame = layer.bounds.insetBy(dx: 5, dy: 5)
        fillCircleLayer.path = UIBezierPath(ovalIn: fillCircleLayer.bounds).cgPath
    }

    // MARK: - Tracking

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        isOn.toggle()
        return false
    }

}
