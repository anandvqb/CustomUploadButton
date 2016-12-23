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
    static let uploadImageName = String("upload")
    static let checkmarkImageName = String("check")
}

public class CustomUploadButton : UIView {
    
    public weak var delegate: CustomUploadButtonActionDelegate?
    
    private var angle = CGFloat(M_PI_4)
    
    private var titleLabel: UILabel!
    private var uploadImageView: UIImageView!
    private var baseRectangleView: UIControl!
    
    private var baseCircleView: UIView!
    private var outerCircleView: UIView!
    private var innerCircleView: UIView!
    private var expandingCircleView: UIView!
    private var successCircleView: UIView!
    private var checkmarkImageView: UIImageView!
    
    private var baseCircleDimension: CGFloat!
    
    private var breakLoop = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpButton()
    }
    
    private func setUpButton() {
        baseRectangleView = UIControl(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        baseRectangleView.backgroundColor = Constants.bgColor
        baseRectangleView.layer.cornerRadius = self.frame.height/3
        baseRectangleView.clipsToBounds = true
        
        var uploadImage = UIImage()
        let podBundle = Bundle(for: CustomUploadButton.self)
        
        if let url = podBundle.url(forResource: "CustomUploadButton", withExtension: "bundle"){
            let submitButtonResoursesBundle = Bundle(url: url)
            uploadImage = UIImage(named: Constants.uploadImageName!, in: submitButtonResoursesBundle, compatibleWith: nil)!
        }
        
        uploadImageView = UIImageView(image: uploadImage)
        uploadImageView.frame.origin = CGPoint(x: (self.frame.width - uploadImageView.frame.size.width - 20), y: (self.frame.height - uploadImageView.frame.size.height)/2)
        baseRectangleView.addSubview(uploadImageView)
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: (self.frame.width - uploadImage.size.width - 50), height: self.frame.height))
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.text = Constants.title
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.baselineAdjustment = .alignCenters
        baseRectangleView.addSubview(titleLabel)
        
        baseRectangleView.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        self.addSubview(baseRectangleView)
        
        baseCircleDimension = self.frame.height
    }
    
    func buttonTouched() {
        var circleDimension: CGFloat = baseCircleDimension
        
        self.titleLabel.textColor = UIColor.clear
        self.baseRectangleView.removeTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        
        baseCircleView = UIView(frame: CGRect(x: (self.frame.width - baseCircleDimension)/2, y: 0, width: baseCircleDimension, height: baseCircleDimension))
        
        circleDimension -= 5
        outerCircleView = CircleView(frame: CGRect(x: (self.frame.width - circleDimension)/2, y: 2.5, width: circleDimension, height: circleDimension))
        
        circleDimension -= 10
        innerCircleView = CircleView(frame: CGRect(x: (self.frame.width - circleDimension)/2, y: 7.5, width: circleDimension, height: circleDimension))
        
        expandingCircleView = UIView(frame: CGRect(x: (self.frame.width - 10)/2, y: 15, width: 10, height: 10))
        successCircleView = UIView(frame: CGRect(x: (self.frame.width - 30)/2, y: 5, width: 30, height: 30))
        
        var checkmarkImage = UIImage()
        let podBundle = Bundle(for: CustomUploadButton.self)
        
        if let url = podBundle.url(forResource: "CustomUploadButton", withExtension: "bundle"){
            let submitButtonResoursesBundle = Bundle(url: url)
            checkmarkImage = UIImage(named: Constants.checkmarkImageName!, in: submitButtonResoursesBundle, compatibleWith: nil)!
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
    
    //Shrinking animation on the base rectangle view
    private func animateRectangle() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.addSubview(self.baseCircleView)
            self.addSubview(self.outerCircleView)
            self.addSubview(self.innerCircleView)
            
            self.breakLoop = false
            self.rotateCircle()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.baseRectangleView.transform = CGAffineTransform(scaleX: 0.3, y: 1.0)
        }, completion: { (value: Bool) in
            self.baseRectangleView.isHidden = true
        })
    }
    
    //Animating the concentric circles
    private func rotateCircle() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
            self.innerCircleView.transform = CGAffineTransform(rotationAngle: self.angle)
            self.outerCircleView.transform = CGAffineTransform(rotationAngle: -self.angle)
        }, completion: { (value: Bool) in
            if self.breakLoop {
                for subview in self.subviews {
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
                        for subview in self.subviews {
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
    
    public func disableButton() {
        self.alpha = 0.5
        self.isUserInteractionEnabled = false
    }
    
    public func enableButton() {
        self.alpha = 1.0
        self.isUserInteractionEnabled = true
    }
}
