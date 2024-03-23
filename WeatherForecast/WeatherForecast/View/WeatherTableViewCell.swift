//
//  WeatherForecast - WeatherTableViewCell.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class WeatherTableViewCell: UITableViewCell {
    lazy var weatherIcon = UIImageView()
    lazy var dateLabel = UILabel(textColor: .black,
                                 font: .preferredFont(forTextStyle: .body),
                                 numberOfLines: 1)
    lazy var temperatureLabel = UILabel(textColor: .black,
                                   font: .preferredFont(forTextStyle: .body),
                                   numberOfLines: 1)
    lazy var weatherLabel = UILabel(textColor: .black,
                               font: .preferredFont(forTextStyle: .body),
                               numberOfLines: 1)
    lazy var descriptionLabel = UILabel(textColor: .black,
                                   font: .preferredFont(forTextStyle: .body),
                                   numberOfLines: 1)
    lazy var dashLabel = UILabel(textColor: .black,
                                 font: .preferredFont(forTextStyle: .body),
                                 numberOfLines: 1)
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        reset()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func layoutLabels() {
        let labels: [UILabel] = [dateLabel, temperatureLabel, weatherLabel, dashLabel, descriptionLabel]
        
        labels.forEach { label in
            label.textColor = .black
            label.font = .preferredFont(forTextStyle: .body)
            label.numberOfLines = 1
        }
        
        descriptionLabel.setContentHuggingPriority(.defaultLow,
                                                   for: .horizontal)
    }
    
    private func weatherStackView() -> UIStackView {
        let weatherStackView = UIStackView(arrangedSubviews: [
            weatherLabel,
            dashLabel,
            descriptionLabel
        ])
        
        weatherStackView.axis = .horizontal
        weatherStackView.spacing = 8
        weatherStackView.alignment = .center
        weatherStackView.distribution = .fill
        
        return weatherStackView
    }
    
    private func verticalStackView() -> UIStackView {
        let weatherStackView = weatherStackView()
        
        let verticalStackView: UIStackView = UIStackView(arrangedSubviews: [
            dateLabel,
            temperatureLabel,
            weatherStackView
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .leading
        
        return verticalStackView
    }
    
    private func contentsStackView() -> UIStackView {
        let verticalStackView = verticalStackView()
        
        let contentsStackView: UIStackView = UIStackView(arrangedSubviews: [
            weatherIcon,
            verticalStackView
        ])
        
        contentsStackView.axis = .horizontal
        contentsStackView.spacing = 16
        contentsStackView.alignment = .center
        contentsStackView.distribution = .fill
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
               
        return contentsStackView
    }
    
    private func layoutContentsStackView() {
        let contentsStackView = contentsStackView()
        contentView.addSubview(contentsStackView)

        NSLayoutConstraint.activate([
            contentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            weatherIcon.widthAnchor.constraint(equalTo: weatherIcon.heightAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupLayout() {
        layoutLabels()
        layoutContentsStackView()
    }
    
    private func reset() {
        weatherIcon.image = UIImage(systemName: Placeholder.weatherIcon)
        dateLabel.text = Placeholder.dateLabel
        temperatureLabel.text = Placeholder.temperatureLabel
        weatherLabel.text = Placeholder.weatherLabel
        descriptionLabel.text = Placeholder.descriptionLabel
    }
}

enum Placeholder {
    static let weatherIcon = "arrow.down.circle.dotted"
    static let dateLabel = "0000-00-00 00:00:00"
    static let temperatureLabel = "00℃"
    static let weatherLabel = "~~~"
    static let descriptionLabel = "~~~~~"
}
