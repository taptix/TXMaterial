//
//  ViewController.swift
//  MDTest
//
//  Created by Andy Rennard on 15/12/2014.
//  Copyright (c) 2014 taptix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var progressView: MDProgressView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewDidAppear(animated: Bool) {
		self.progressView.animateIndeterminate()
	}
	
}

