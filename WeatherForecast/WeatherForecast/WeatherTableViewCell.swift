//
//  WeatherForecast - WeatherTableViewCell.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class WeatherTableViewCell: UITableViewCell, ReusableCell {
    typealias SuperView = UITableView
    
    var weatherIcon: UIImageView!
    var dateLabel: UILabel!
    var temperatureLabel: UILabel!
    var weatherLabel: UILabel!
    var dashLabel: UILabel!
    var descriptionLabel: UILabel!
    private var imageTask: Task<Void, Error>?
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubviews()
        setLayoutSubviews()
        reset()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reset()
        imageTask?.cancel()
    }
    
    func configureCell(with weatherForecastInfo: WeatherForecastInfo, tempUnit: TempUnit) {
        weatherLabel.text = weatherForecastInfo.weather.main
        descriptionLabel.text = weatherForecastInfo.weather.description
        temperatureLabel.text = "\(weatherForecastInfo.main.temp)\(tempUnit.expression)"
        
        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.locale = .init(identifier: "ko_KR")
            df.dateFormat = "yyyy-MM-dd(EEEEE) a HH:mm"
            return df
        }()
        
        let date: Date = Date(timeIntervalSince1970: weatherForecastInfo.dt)
        dateLabel.text = dateFormatter.string(from: date)
    }
    
    func setImage(with imageUrl: String) {
        self.imageTask = Task {
            let icon = try await ImageLoader.shared.fetchImageFromNetwork(with: imageUrl)
            weatherIcon.image = icon
        }
    }
    
    private func setSubviews() {
        weatherIcon = UIImageView()
        dateLabel = UILabel()
        temperatureLabel = UILabel()
        weatherLabel = UILabel()
        dashLabel = UILabel()
        descriptionLabel = UILabel()
        
        let labels: [UILabel] = [dateLabel, temperatureLabel, weatherLabel, dashLabel, descriptionLabel]
        
        labels.forEach { label in
            label.textColor = .black
            label.font = .preferredFont(forTextStyle: .body)
            label.numberOfLines = 1
        }
    }
    
    private func setLayoutSubviews() {
        let weatherStackView: UIStackView = UIStackView(arrangedSubviews: [
            weatherLabel,
            dashLabel,
            descriptionLabel
        ])
        
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        weatherStackView.axis = .horizontal
        weatherStackView.spacing = 8
        weatherStackView.alignment = .center
        weatherStackView.distribution = .fill
        
        
        let verticalStackView: UIStackView = UIStackView(arrangedSubviews: [
            dateLabel,
            temperatureLabel,
            weatherStackView
        ])
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .leading
        
        let contentsStackView: UIStackView = UIStackView(arrangedSubviews: [
            weatherIcon,
            verticalStackView
        ])
               
        contentsStackView.axis = .horizontal
        contentsStackView.spacing = 16
        contentsStackView.alignment = .center
        contentsStackView.distribution = .fill
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    private func reset() {
        weatherIcon.image = UIImage(systemName: "arrow.down.circle.dotted")
        dateLabel.text = "0000-00-00 00:00:00"
        temperatureLabel.text = "00℃"
        weatherLabel.text = "~~~"
        descriptionLabel.text = "~~~~~"
    }
}
