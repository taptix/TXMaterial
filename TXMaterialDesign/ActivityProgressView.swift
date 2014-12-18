//
//  MDProgressView.swift
//  MDTest
//
//  Created by Andy Rennard on 15/12/2014.
//  Copyright (c) 2014 taptix. All rights reserved.
//

import UIKit

@IBDesignable public class ActivityProgressView : UIView{

	@IBInspectable public var tint : UIColor = UIColor(red: 0.239, green: 0.537, blue: 0.969, alpha: 1.000)
	@IBInspectable public var isIndeterminate : Bool = false
	@IBInspectable public var alwaysAnimate : Bool = false

	private let strokeStartAnimationKey = "progressAnimationStrokeStart"
	private let strokeEndAnimationKey = "progressAnimationStrokeEnd"
	private  let rotationAnimationKey = "progressAnimationRotation"
	
	public var isAnimating : Bool = false{
		didSet{
			self.animate()
		}
	}
	public var progress : Float = 0.0 {
		willSet{
			self.isIndeterminate = false
			self.removeAnimations()
		}
		didSet{
			if self.isAnimating{
				self.stopAnimating()
			}
			if self.alwaysAnimate{
				self.startAnimating()
			}
		}
	}
	
	let shapeLayer = CAShapeLayer()

	override public init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}

	required public init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}

	override public func awakeFromNib() {
		super.awakeFromNib()
		self.setup()
	}
	
	public func setProgress(progress: Float, animated: Bool){
		self.progress = progress
		self.shapeLayer.strokeStart = CGFloat(self.progress / 2.0)
		self.shapeLayer.strokeEnd = CGFloat(self.progress)

		if	animated{
			let timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 0.0, 0.5, 1.0)
			let presentationLayer = self.shapeLayer.presentationLayer() as CAShapeLayer
			let progressAnim = CABasicAnimation(keyPath: "strokeEnd")
			progressAnim.fromValue = presentationLayer.strokeEnd
			progressAnim.toValue = CGFloat(self.progress)
			progressAnim.duration = 1.0
			progressAnim.timingFunction = timingFunction
			self.shapeLayer.addAnimation(progressAnim, forKey: "setStrokeEnd")
			
			let progressAnim2 = CABasicAnimation(keyPath: "strokeStart")
			progressAnim2.fromValue = presentationLayer.strokeStart
			progressAnim2.toValue = CGFloat(self.progress / 2.0)
			progressAnim2.duration = 1.0
			progressAnim2.timingFunction = timingFunction
			self.shapeLayer.addAnimation(progressAnim2, forKey: "setStrokeStart")
		}
	}
	
	
	func startAnimating(){
		self.isAnimating = true
	}
	func stopAnimating(){
		self.isAnimating = false
	}

	private func setup(){
		self.shapeLayer.frame = self.bounds
		self.shapeLayer.fillColor = UIColor.clearColor().CGColor
		self.shapeLayer.strokeColor = tint.CGColor
		self.shapeLayer.lineWidth = frame.size.height / 10.0
		self.shapeLayer.lineJoin = kCALineJoinRound
		self.shapeLayer.lineCap = kCALineCapRound
		self.shapeLayer.strokeStart = 0.0
		self.shapeLayer.strokeEnd = 0.0
		self.shapeLayer.anchorPoint = CGPointMake(0.5, 0.5)
		
		let path = CGPathCreateMutable()
		var transform = CGAffineTransformMakeRotation(CGFloat(-M_PI/2.0))

		CGPathAddEllipseInRect(path, nil,
			CGRectInset(self.bounds, self.shapeLayer.lineWidth / 2.0, self.shapeLayer.lineWidth / 2.0))
		CGPathAddEllipseInRect(path, nil,
			CGRectInset(self.bounds, self.shapeLayer.lineWidth / 2.0, self.shapeLayer.lineWidth / 2.0))

		self.shapeLayer.transform = CATransform3DMakeRotation(CGFloat(-M_PI/2.0), 0.0, 0.0, 1.0)
		self.shapeLayer.path = path
		self.layer.addSublayer(self.shapeLayer)
	}

	private func animate(){
		if self.isAnimating{

			if self.isIndeterminate{
				self.shapeLayer.strokeStart = 0.0
				self.shapeLayer.strokeEnd = 0.0

				let progressAnim = CABasicAnimation(keyPath: "strokeEnd")
				progressAnim.fromValue = self.shapeLayer.strokeEnd
				progressAnim.toValue = 0.5
				progressAnim.repeatCount = MAXFLOAT
				progressAnim.duration = 1.5
				progressAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.3, 0.0, 0.3, 1.0)
				self.shapeLayer.addAnimation(progressAnim, forKey: strokeEndAnimationKey)
				
				let progressAnim2 = CABasicAnimation(keyPath: "strokeStart")
				progressAnim2.fromValue = self.shapeLayer.strokeStart
				progressAnim2.toValue = 0.5
				progressAnim2.repeatCount = MAXFLOAT
				progressAnim2.duration = 1.5
				progressAnim2.timingFunction = CAMediaTimingFunction(controlPoints: 0.9, 0.0, 0.8, 1.0)
				self.shapeLayer.addAnimation(progressAnim2, forKey: strokeStartAnimationKey)
				
			}
			
			let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
			rotationAnimation.duration = 2.5
			rotationAnimation.fromValue = 0.0
			let finalAngle = CGFloat(2*M_PI)
			rotationAnimation.toValue = finalAngle
			rotationAnimation.repeatCount = MAXFLOAT
			self.shapeLayer.addAnimation(rotationAnimation, forKey: rotationAnimationKey)
			
		}
		else {
			self.removeAnimations()
		}
	}

	private func removeAnimations(){
		let keys = [strokeEndAnimationKey, strokeStartAnimationKey, rotationAnimationKey]
		for key in keys {
			if let animation = self.shapeLayer.animationForKey(key){
				self.shapeLayer.removeAnimationForKey(key)
			}
		}
		self.shapeLayer.transform = CATransform3DMakeRotation(CGFloat(-M_PI/2.0), 0.0, 0.0, 1.0)
		
	}

}
