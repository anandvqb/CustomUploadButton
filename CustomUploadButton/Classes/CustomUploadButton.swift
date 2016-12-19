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
    let bgColorWithAlpha = UIColor(red: 96/255.0, green: 124/255.0, blue: 157/255.0, alpha: 0.1)
    let bgColorForSuccessView = UIColor(red: 102/255.0, green: 158/255.0, blue: 99/255.0, alpha: 1.0)
    
    var angle = CGFloat(M_PI_4)
    
    var baseRectangleView: UIView!
    var baseCircleView: UIView!
    var outerCircleView: UIView!
    var innerCircleView: UIView!
    var animatingCircleView: UIView!
    var successCircleView: UIView!
    var checkmarkImageView: UIImageView!
    
    var breakLoop = false
    
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
        self.removeTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        
        baseRectangleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        baseCircleView = UIView(frame: CGRect(x: (buttonFrame.width - 55)/2, y: 5, width: 55, height: 55))
        outerCircleView = CircleView(frame: CGRect(x: (buttonFrame.width - 45)/2, y: 10, width: 45, height: 45))
        innerCircleView = CircleView(frame: CGRect(x: (buttonFrame.width - 30)/2, y: 17.5, width: 30, height: 30))
        animatingCircleView = UIView(frame: CGRect(x: (buttonFrame.width - 10)/2, y: 27.5, width: 10, height: 10))
        successCircleView = UIView(frame: CGRect(x: (buttonFrame.width - 30)/2, y: 17.5, width: 30, height: 30))
        
        let bundle = Bundle(for: CustomUploadButton.self)
        let checkmarkImage = UIImage(named: "check", in: bundle, compatibleWith: nil)
        
        checkmarkImageView = UIImageView(image: checkmarkImage)
        checkmarkImageView.center = self.center
        
        baseRectangleView.layer.cornerRadius = 25.0
        baseRectangleView.clipsToBounds = true
        baseRectangleView.backgroundColor = bgColor
        
        baseCircleView.layer.cornerRadius = baseCircleView.frame.size.width/2
        baseCircleView.clipsToBounds = true
        baseCircleView.backgroundColor = bgColor
        
        animatingCircleView.layer.cornerRadius = animatingCircleView.frame.size.width/2
        animatingCircleView.clipsToBounds = true
        animatingCircleView.backgroundColor = bgColorWithAlpha
        
        successCircleView.layer.cornerRadius = successCircleView.frame.size.width/2
        successCircleView.clipsToBounds = true
        successCircleView.backgroundColor = bgColorForSuccessView
        
        self.addSubview(baseRectangleView)
        
        self.animateRectangle()
    }
    
    func animateRectangle() {
        let buttonFrame = self.frame
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.baseRectangleView.transform = CGAffineTransform(scaleX: 0.1, y: 1.0)
        }, completion: { (value: Bool) in
            self.baseRectangleView.isHidden = true
            self.addSubview(self.baseCircleView)
            self.addSubview(self.outerCircleView)
            self.addSubview(self.innerCircleView)
            self.rotateCircle()
        })
    }
    
    func rotateCircle() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.innerCircleView.transform = CGAffineTransform(rotationAngle: self.angle)
            self.outerCircleView.transform = CGAffineTransform(rotationAngle: -self.angle)
        }, completion: { (value: Bool) in
            if self.breakLoop {
                let subViews = self.subviews
                for subview in subViews {
                    subview.removeFromSuperview()
                }
                
                self.addSubview(self.animatingCircleView)
                UIView.animate(withDuration: 0.4, animations: { () -> Void in
                    self.animatingCircleView.transform = CGAffineTransform(scaleX: 5, y: 5)
                }) { (finished) -> Void in
                    self.animatingCircleView.removeFromSuperview()
                    self.addSubview(self.successCircleView)
                    self.addSubview(self.checkmarkImageView)
                }
            }
            else {
                self.angle += CGFloat(M_PI_4)
                self.rotateCircle()
                self.breakLoop = true
            }
        })
    }
}
