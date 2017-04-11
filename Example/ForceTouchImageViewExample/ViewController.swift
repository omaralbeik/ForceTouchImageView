//
//  ViewController.swift
//  ForceTouchImageViewExample
//
//  Created by Omar Albeik on 4/9/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView: ForceTouchImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.layer.cornerRadius = 25
		
	}

}

