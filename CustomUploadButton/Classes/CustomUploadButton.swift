//
//  CustomUploadButton.swift
//  Pods
//
//  Created by Anand on 09/12/16.
//
//

import Foundation

public protocol CustomUploadButtonActionDelegate: class {
    func buttonAction(sender:CustomUploadButton)
}

private struct Constants {
    
    static let title = String("Upload")
    static let bgColor = UIColor(red: 96/255.0, green: 124/255.0, blue: 157/255.0, alpha: 1.0)
    static let bgColorWithAlpha = UIColor(red: 96/255.0, green: 124/255.0, blue: 157/255.0, alpha: 0.1)
    static let bgColorForSuccessView = UIColor(red: 102/255.0, green: 158/255.0, blue: 99/255.0, alpha: 1.0)
}

public class CustomUploadButton : UIView {
    
    public var delegate: CustomUploadButtonActionDelegate?
    
    var angle = CGFloat(M_PI_4)
    
    var titleLabel: UILabel!
    var baseRectangleView: UIControl!
    var baseCircleView: UIView!
    var outerCircleView: UIView!
    var innerCircleView: UIView!
    var expandingCircleView: UIView!
    var successCircleView: UIView!
    var checkmarkImageView: UIImageView!
    
    var breakLoop = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpButton()
    }
    
    public func setUpButton() {
        baseRectangleView = UIControl(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        baseRectangleView.backgroundColor = Constants.bgColor
        baseRectangleView.layer.cornerRadius = 25.0
        baseRectangleView.clipsToBounds = true
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.text = Constants.title
        titleLabel.textAlignment = .center
        baseRectangleView.addSubview(titleLabel)
        
        baseRectangleView.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        self.addSubview(baseRectangleView)
    }
    
    func buttonTouched() {
        let buttonFrame = self.frame
        
        self.titleLabel.textColor = UIColor.clear
        self.baseRectangleView.removeTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        
        baseCircleView = UIView(frame: CGRect(x: (buttonFrame.width - 55)/2, y: 5, width: 55, height: 55))
        outerCircleView = CircleView(frame: CGRect(x: (buttonFrame.width - 45)/2, y: 10, width: 45, height: 45))
        innerCircleView = CircleView(frame: CGRect(x: (buttonFrame.width - 30)/2, y: 17.5, width: 30, height: 30))
        animatingCircleView = UIView(frame: CGRect(x: (buttonFrame.width - 10)/2, y: 27.5, width: 10, height: 10))
        successCircleView = UIView(frame: CGRect(x: (buttonFrame.width - 30)/2, y: 17.5, width: 30, height: 30))
        
        let image = UIImage(named: "check")
        
        var checkmarkImage = UIImage()
        let podBundle = Bundle(for: CustomUploadButton.self)
        
        if let url = podBundle.url(forResource: "CustomUploadButton", withExtension: "bundle"){
            let submitButtonResoursesBundle = Bundle(url: url)
            checkmarkImage = UIImage(named: "check", in: submitButtonResoursesBundle, compatibleWith: nil)!
        }
        
        checkmarkImageView = UIImageView(image: checkmarkImage)
        checkmarkImageView.center = successCircleView.center
        
        baseCircleView.layer.cornerRadius = baseCircleView.frame.size.width/2
        baseCircleView.clipsToBounds = true
        baseCircleView.backgroundColor = Constants.bgColor
        
        expandingCircleView.layer.cornerRadius = expandingCircleView.frame.size.width/2
        expandingCircleView.clipsToBounds = true
        expandingCircleView.backgroundColor = Constants.bgColorWithAlpha
        
        successCircleView.layer.cornerRadius = successCircleView.frame.size.width/2
        successCircleView.clipsToBounds = true
        successCircleView.backgroundColor = Constants.bgColorForSuccessView
        
        self.animateRectangle()
        
        self.delegate?.buttonAction(sender: self)
    }
    
    func animateRectangle() {
        let buttonFrame = self.frame
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.addSubview(self.baseCircleView)
            self.addSubview(self.outerCircleView)
            self.addSubview(self.innerCircleView)
            
            self.breakLoop = false
            self.rotateCircle()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.baseRectangleView.transform = CGAffineTransform(scaleX: 0.6, y: 1.0)
        }, completion: { (value: Bool) in
            self.baseRectangleView.isHidden = true
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
                
                self.addSubview(self.expandingCircleView)
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.expandingCircleView.transform = CGAffineTransform(scaleX: 5, y: 5)
                }) { (finished) -> Void in
                    self.expandingCircleView.removeFromSuperview()
                    self.addSubview(self.successCircleView)
                    self.addSubview(self.checkmarkImageView)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        let subViews = self.subviews
                        for subview in subViews {
                            subview.removeFromSuperview()
                        }
                        
                        self.baseRectangleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                        self.baseRectangleView.isHidden = false
                        self.titleLabel.textColor = UIColor.white
                        self.addSubview(self.baseRectangleView)
                        self.baseRectangleView.addTarget(self, action: #selector(self.buttonTouched), for: .touchUpInside)
                        
                        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                            self.baseRectangleView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        })
                    }
                }
            }
            else {
                self.angle += CGFloat(M_PI_4)
                self.rotateCircle()
            }
        })
    }
    
    public func stopAnimation() {
        self.breakLoop = true
    }
}
