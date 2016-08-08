import UIKit

/// 内部圆圈的旋转动画
class SpinerLayer: CAShapeLayer {

	var spinnerColor = UIColor.whiteColor() {
		didSet {
			strokeColor = spinnerColor.CGColor
		}
	}

	init(frame: CGRect) {
		super.init()
		// 画圆
		let radius: CGFloat = (frame.height / 2) * 0.5
		self.frame = CGRectMake(0, 0, frame.height, frame.height)
		let center = CGPointMake(frame.height / 2, bounds.center.y)
		let startAngle = 0 - M_PI_2
		let endAngle = M_PI * 2 - M_PI_2
		let clockwise: Bool = true
		self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).CGPath

		// 设置线的属性
		self.fillColor = nil
		self.strokeColor = spinnerColor.CGColor
		self.lineWidth = 1
		// 设置动画结束位置
		self.strokeEnd = 0.4
		self.hidden = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	/**
	  添加动画
	 */
	func animation() {
		self.hidden = false
		// 路径为旋转的动画
		let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
		// 动画起止位置
		rotate.fromValue = 0
		rotate.toValue = M_PI * 2
		rotate.duration = 0.4
		rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
		// 重复次数
		rotate.repeatCount = HUGE
		rotate.fillMode = kCAFillModeForwards
		rotate.removedOnCompletion = false
		self.addAnimation(rotate, forKey: rotate.keyPath)

	}
	/**
	 停止动画,隐藏界面
	 */
	func stopAnimation() {
		self.hidden = true
		self.removeAllAnimations()
	}
}