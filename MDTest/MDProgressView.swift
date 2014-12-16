//
//  MDProgressView.swift
//  MDTest
//
//  Created by Andy Rennard on 15/12/2014.
//  Copyright (c) 2014 taptix. All rights reserved.
//

import UIKit

class MDProgressView : UIView{

	let tint = UIColor.blueColor()
	let shapeLayer = CAShapeLayer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		self.setup()
	}
	
	func setup(){
		self.shapeLayer.frame = self.bounds
		self.shapeLayer.fillColor = UIColor.clearColor().CGColor
		self.shapeLayer.strokeColor = UIColor(red: 0.239, green: 0.537, blue: 0.969, alpha: 1.000).CGColor
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

		self.shapeLayer.transform = CATransform3DMakeRotation(CGFloat(-M_PI/2.0), 0.0, 0.0, 1.0)
		self.shapeLayer.path = path
		self.layer.addSublayer(self.shapeLayer)
	}

	
	func animateIndeterminate(){
		self.shapeLayer.strokeStart = 0.0
		self.shapeLayer.strokeEnd = 0.0
		
		let progressAnim = CABasicAnimation(keyPath: "strokeEnd")
		progressAnim.fromValue = 0.0
		progressAnim.toValue = 1.0
		progressAnim.repeatCount = MAXFLOAT
		progressAnim.fillMode = kCAFillModeForwards
		progressAnim.removedOnCompletion = false
		progressAnim.additive = true
		progressAnim.duration = 1.5
		progressAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.3, 0.0, 0.3, 1.0)
		self.shapeLayer.addAnimation(progressAnim, forKey: "progressAnimation")

		
		let progressAnim2 = CABasicAnimation(keyPath: "strokeStart")
		progressAnim2.fromValue = 0.0
		progressAnim2.toValue = 1.0
		progressAnim2.repeatCount = MAXFLOAT
		progressAnim2.fillMode = kCAFillModeForwards
		progressAnim2.removedOnCompletion = false
		progressAnim2.additive = true
		progressAnim2.duration = 1.5
//		progressAnim2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
		progressAnim2.timingFunction = CAMediaTimingFunction(controlPoints: 0.9, 0.0, 0.8, 1.0)
		self.shapeLayer.addAnimation(progressAnim2, forKey: "progressAnimation2")
		
		
		let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
		rotationAnimation.duration = 2.5
		rotationAnimation.fromValue = 0.0
		let finalAngle = CGFloat(2*M_PI)
		rotationAnimation.toValue = finalAngle
		rotationAnimation.repeatCount = MAXFLOAT
		rotationAnimation.cumulative = true
		rotationAnimation.removedOnCompletion = false
		rotationAnimation.fillMode = kCAFillModeForwards
		rotationAnimation.additive = true
		
		self.shapeLayer.addAnimation(rotationAnimation, forKey: "transform.rotation")

		

	}
}
