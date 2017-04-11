//
//  ForceTouchImageView.swift
//  ForceTouchImageView
//
//  Created by Omar Albeik on 4/9/17.
//  Copyright © 2017 Omar Albeik. All rights reserved.
//

import UIKit

public protocol ForceTouchImageViewDelegate: class {
	func forceTouchImageView(_ view: ForceTouchImageView, touchForceDidChange force: CGFloat)
}

extension ForceTouchImageViewDelegate {
	func forceTouchImageView(_ view: ForceTouchImageView, touchForceDidChange force: CGFloat) {}
}


@IBDesignable
public class ForceTouchImageView: UIScrollView {
	
	public weak var forceTouchDelegate: ForceTouchImageViewDelegate?
	public var maximumPossibleForce: CGFloat = 0
	
	
	fileprivate var imageView: UIImageView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}
	
	@IBInspectable
	public var image: UIImage? {
		get {
			return imageView.image
		}
		set {
			imageView.image = newValue
		}
	}
	
	@IBInspectable
	public var highlightedImage: UIImage? {
		get {
			return imageView.highlightedImage
		}
		set {
			imageView.highlightedImage = newValue
		}
	}
	
}


// MARK: - Touch methdos
public extension ForceTouchImageView {
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		guard let touch = touches.first else { return }
		
		guard #available(iOS 9.0, *) else {
			debugPrint("ForceTouchImageView: Device does not support ForchTouch")
			return
		}
		
		guard traitCollection.forceTouchCapability == UIForceTouchCapability.available else {
			debugPrint("ForceTouchImageView: Device does not support ForchTouch")
			return
		}
		
		forceTouchDelegate?.forceTouchImageView(self, touchForceDidChange: touch.force)
		
		let scale = (touch.force*maximumZoomScale)/touch.maximumPossibleForce
		setZoomScale(scale, animated: true)
		
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		forceTouchDelegate?.forceTouchImageView(self, touchForceDidChange: 0)
		setZoomScale(1.0, animated: true)
	}
	
}


// MARK: - UIScrollViewDelegate
extension ForceTouchImageView: UIScrollViewDelegate {
	
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	
}


// MARK: - Helpers
extension ForceTouchImageView {
	
	func setupView() {
		
		clipsToBounds = true
		bounces = false
		
		if imageView == nil {
			imageView = UIImageView(frame: self.bounds)
		}
		
		imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		imageView.contentMode = .scaleAspectFill
		imageView.isUserInteractionEnabled = true
		addSubview(imageView)
		
		minimumZoomScale = 1.0
		maximumZoomScale = 4.0
		
		delegate = self
		setupGestureRecognizers()
	}
	
	func setupGestureRecognizers() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(respondToTap(sender:)))
		tap.numberOfTapsRequired = 2
		addGestureRecognizer(tap)
	}
	
	func respondToTap(sender: UITapGestureRecognizer) {
		let rect = zoomRect(for: 3.0, center: sender.location(in: self))
		zoom(to: rect, animated: true)
	}
	
	func zoomRect(for scale: CGFloat, center: CGPoint) -> CGRect {
		var zoomRect = CGRect.zero
		zoomRect.size.height = frame.size.height / scale
		zoomRect.size.width  = frame.size.width  / scale
		let newCenter = imageView.convert(center, from: self)
		zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
		zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
		return zoomRect
	}
	
	var midiumZoomScale: CGFloat {
		return (maximumZoomScale-minimumZoomScale)/2.0
	}
}

