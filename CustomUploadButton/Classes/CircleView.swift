//
//  CircleView.swift
//  Pods
//
//  Created by Anand on 08/12/16.
//
//

import Foundation

class CircleView: UIView {
    
    var circleLayer: CAShapeLayer!
    var isAnimating = false
    
    var fromValue:CGFloat = 0.0
    var toValue:CGFloat = 0.95
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = 3.0;
        
        // Don't draw the circle initially
        circleLayer.strokeEnd = 0.0
        circleLayer.strokeStart = self.fromValue
        circleLayer.strokeEnd = self.toValue
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(circleLayer)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
