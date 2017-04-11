//
//  ViewController.swift
//  ForceTouchImageViewExample
//
//  Created by Omar Albeik on 4/9/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit
import ForceTouchImageView

class ViewController: UIViewController {

	@IBOutlet weak var imageView: ForceTouchImageView!
	@IBOutlet weak var forceProgressView: UIProgressView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.forceTouchDelegate = self
		imageView.layer.cornerRadius = 25
		
	}

}


extension ViewController: ForceTouchImageViewDelegate {
	
	func forceTouchImageView(_ view: ForceTouchImageView, touchForceDidChange force: CGFloat) {
		forceProgressView.progress = Float(force/6.6)
	}
	
}

