//
//  CircularProgressBar.swift
//  WaterReminder
//
//  Created by ульяна on 19.01.24.
//

import UIKit

class CircularProgressBar: UIView {
    
    private let progressLayer = CAShapeLayer()
    
    var totalWaterIntake: Int = 0
    
    var progress: CGFloat = 0 {
        didSet {
            updateProgress()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressBar()
    }
    
    convenience init(frame: CGRect, totalWaterIntake: Int) {
          self.init(frame: frame)
          self.totalWaterIntake = totalWaterIntake
          setupProgressBar()
      }
    
    private func setupProgressBar() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - 5
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.strokeColor = UIColor.blue.cgColor
        progressLayer.lineWidth = 30
        progressLayer.fillColor = UIColor.white.cgColor
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
        updateProgress()
    }
    
    private func updateProgress() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = progressLayer.strokeEnd
        animation.toValue = progress
        animation.duration = 0.7
        progressLayer.strokeEnd = progress
        progressLayer.add(animation, forKey: "progressAnimation")
    }
}

/*
// Only override draw() if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
override func draw(_ rect: CGRect) {
    // Drawing code
}
*/
