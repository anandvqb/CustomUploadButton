//
//  CustomUploadButton.swift
//  Pods
//
//  Created by Anand on 09/12/16.
//
//

import Foundation

public class CustomUploadButton : UIButton {
    
    let bgColor = UIColor(red: 96/255.0, green: 124/255.0, blue: 157/255.0, alpha: 1.0)
    
    var angle = CGFloat(M_PI_4)
    
    var baseCircleView: UIView!
    var outerCircleView: UIView!
    var innerCircleView: UIView!
    
    public func setUpButton(title:String) {
        self.backgroundColor = bgColor
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitle(title, for: .normal)
        
        self.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
    }
    
    func buttonTouched() {
        let buttonFrame = self.frame
        
        self.backgroundColor = UIColor.clear
        self.setTitleColor(UIColor.clear, for: .normal)
        
        baseCircleView = UIView(frame: CGRect(x: (buttonFrame.width - 55)/2, y: 5, width: 55, height: 55))
        outerCircleView = CircleView(frame: CGRect(x: (buttonFrame.width - 45)/2, y: 10, width: 45, height: 45))
        innerCircleView = CircleView(frame: CGRect(x: (buttonFrame.width - 30)/2, y: 17.5, width: 30, height: 30))
        
        baseCircleView.layer.cornerRadius = baseCircleView.frame.size.width/2
        baseCircleView.clipsToBounds = true
        baseCircleView.backgroundColor = bgColor
        
        self.addSubview(baseCircleView)
        self.addSubview(outerCircleView)
        self.addSubview(innerCircleView)
        
        self.rotateCircle()
    }
    
    func rotateCircle() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.innerCircleView.transform = CGAffineTransform(rotationAngle: self.angle)
            self.outerCircleView.transform = CGAffineTransform(rotationAngle: -self.angle)
        }, completion: { (value: Bool) in
            self.angle += CGFloat(M_PI_4)
            self.rotateCircle()
        })
    }
}
