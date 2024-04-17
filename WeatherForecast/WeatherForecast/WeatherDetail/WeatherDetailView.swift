//
//  WeatherDetailView.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/17/24.
//

import UIKit

final class WeatherDetailView: UIView {
    
    private let listInfo: WeatherForecastInfo?
    private let tempUnit: TempUnit
    private let cityInfo: City?
    
    init(weatherForecastInfo: WeatherForecastInfo?,
         tempUnit: TempUnit,
         cityInfo: City?) {
        self.listInfo = weatherForecastInfo
        self.tempUnit = tempUnit
        self.cityInfo = cityInfo
        
        super.init(frame: .zero)
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        let iconImageView: UIImageView = UIImageView()
        let weatherGroupLabel: UILabel = UILabel()
        let weatherDescriptionLabel: UILabel = UILabel()
        let temperatureLabel: UILabel = UILabel()
        let feelsLikeLabel: UILabel = UILabel()
        let maximumTemperatureLable: UILabel = UILabel()
        let minimumTemperatureLable: UILabel = UILabel()
        let popLabel: UILabel = UILabel()
        let humidityLabel: UILabel = UILabel()
        let sunriseTimeLabel: UILabel = UILabel()
        let sunsetTimeLabel: UILabel = UILabel()
        let spacingView: UIView = UIView()
        spacingView.backgroundColor = .clear
        spacingView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        let mainStackView: UIStackView = .init(arrangedSubviews: [
            iconImageView,
            weatherGroupLabel,
            weatherDescriptionLabel,
            temperatureLabel,
            feelsLikeLabel,
            maximumTemperatureLable,
            minimumTemperatureLable,
            popLabel,
            humidityLabel,
            sunriseTimeLabel,
            sunsetTimeLabel,
            spacingView
        ])
                
        mainStackView.arrangedSubviews.forEach { subview in
            guard let subview: UILabel = subview as? UILabel else { return }
            subview.textColor = .black
            subview.backgroundColor = .clear
            subview.numberOfLines = 1
            subview.textAlignment = .center
            subview.font = .preferredFont(forTextStyle: .body)
        }
        
        weatherGroupLabel.font = .preferredFont(forTextStyle: .largeTitle)
        weatherDescriptionLabel.font = .preferredFont(forTextStyle: .largeTitle)
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 8
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea: UILayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                                   constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                   constant: -16),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            iconImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor,
                                                 multiplier: 0.3)
        ])
        
        guard let listInfo = listInfo else { return }
        
        weatherGroupLabel.text = listInfo.weather.main
        weatherDescriptionLabel.text = listInfo.weather.description
        temperatureLabel.text = "현재 기온 : \(listInfo.main.temp)\(tempUnit.expression)"
        feelsLikeLabel.text = "체감 기온 : \(listInfo.main.feelsLike)\(tempUnit.expression)"
        maximumTemperatureLable.text = "최고 기온 : \(listInfo.main.tempMax)\(tempUnit.expression)"
        minimumTemperatureLable.text = "최저 기온 : \(listInfo.main.tempMin)\(tempUnit.expression)"
        popLabel.text = "강수 확률 : \(listInfo.main.pop * 100)%"
        humidityLabel.text = "습도 : \(listInfo.main.humidity)%"
        
        if let cityInfo {
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = .none
            formatter.timeStyle = .short
            formatter.locale = .init(identifier: "ko_KR")
            sunriseTimeLabel.text = "일출 : \(formatter.string(from: Date(timeIntervalSince1970: cityInfo.sunrise)))"
            sunsetTimeLabel.text = "일몰 : \(formatter.string(from: Date(timeIntervalSince1970: cityInfo.sunset)))"
        }
        
        Task {
            let iconName: String = listInfo.weather.icon
            let urlString: String = "https://openweathermap.org/img/wn/\(iconName)@2x.png"

            guard let url: URL = URL(string: urlString),
                  let (data, _) = try? await URLSession.shared.data(from: url),
                  let image: UIImage = UIImage(data: data) else {
                return
            }
            
            iconImageView.image = image
        }
    }
}
