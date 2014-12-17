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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewDidAppear(animated: Bool) {
//		self.progressView.animate()
//		self.progressView.isIndeterminate = true
	}
	
	@IBAction func setProgress(sender: AnyObject) {
		let slider = sender as UISlider
		self.progressView.progress = slider.value
	}

	@IBAction func toggleAction(sender: AnyObject) {
		for spinner in self.progressViews{
			spinner.isAnimating = !spinner.isAnimating
		}
	}
}

