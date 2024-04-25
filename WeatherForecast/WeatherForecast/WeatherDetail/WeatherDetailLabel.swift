//
//  WeatherDetailLabel.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/25/24.
//

import UIKit

final class WeatherDetailLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .black
        backgroundColor = .clear
        numberOfLines = 1
        textAlignment = .center
        font = .preferredFont(forTextStyle: .body)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
