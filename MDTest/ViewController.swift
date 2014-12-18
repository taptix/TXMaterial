//
//  ViewController.swift
//  MDTest
//
//  Created by Andy Rennard on 15/12/2014.
//  Copyright (c) 2014 taptix. All rights reserved.
//

import UIKit
import TXMaterialDesign


class ViewController: UIViewController {
	
	@IBOutlet var progressViews: [ActivityProgressView]!
	@IBOutlet weak var progressView: ActivityProgressView!
	
	@IBOutlet weak var slider: UISlider!
	@IBOutlet weak var animateSwitch: UISwitch!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	@IBAction func setProgress(sender: AnyObject) {
		self.progressView.setProgress(self.slider.value, animated: false)
	}

	@IBAction func toggleAction(sender: AnyObject) {
		for spinner in self.progressViews{
			spinner.isAnimating = !spinner.isAnimating
		}
	}

	@IBAction func set0(sender: AnyObject) {
		self.progressView.setProgress(0.0, animated: self.animateSwitch.on)
		self.slider.setValue(0.0, animated: self.animateSwitch.on)
	}
	@IBAction func set25(sender: AnyObject) {
		self.progressView.setProgress(0.25, animated: self.animateSwitch.on)
		self.slider.setValue(0.25, animated: self.animateSwitch.on)
	}
	@IBAction func set50(sender: AnyObject) {
		self.progressView.setProgress(0.50, animated: self.animateSwitch.on)
		self.slider.setValue(0.5, animated: self.animateSwitch.on)
	}
	@IBAction func set75(sender: AnyObject) {
		self.progressView.setProgress(0.75, animated: self.animateSwitch.on)
		self.slider.setValue(0.75, animated: self.animateSwitch.on)
	}
	@IBAction func set100(sender: AnyObject) {
		self.progressView.setProgress(1.0, animated: self.animateSwitch.on)
		self.slider.setValue(1.0, animated: self.animateSwitch.on)
	}
}

