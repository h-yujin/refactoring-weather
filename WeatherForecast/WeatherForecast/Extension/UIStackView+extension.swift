//
//  UIStackView+extension.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/25/24.
//

import UIKit

extension UIStackView {
  convenience init(
      arrangedSubviews views: [UIView],
      alignment: UIStackView.Alignment,
      axis: NSLayoutConstraint.Axis,
      distribution: UIStackView.Distribution = .fill,
      spacing: CGFloat
  ) {
    self.init(arrangedSubviews: views)
    self.alignment = alignment
    self.axis = axis
    self.distribution = distribution
    self.spacing = spacing
  }
}
