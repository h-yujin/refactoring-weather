//
//  TempFormatter.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/19/24.
//

import Foundation

struct TempFormatter {
    
    private let info: WeatherForecastInfo
    private let tempUnit: TempUnit
    
    init(info: WeatherForecastInfo, tempUnit: TempUnit) {
        self.info = info
        self.tempUnit = tempUnit
    }
    
    func temperatureFormat() -> String {
        return String(format: "%0.2f%@", arguments: [celsiusFahrenheitConvert(temp: info.main.temp), tempUnit.expression])
    }
    
    func feelsLikeFormat() -> String {
        return String(format: "%0.2f%@", arguments: [celsiusFahrenheitConvert(temp: info.main.feelsLike), tempUnit.expression])
    }
    
    func maximumTemperatureFormat() -> String {
        return String(format: "%0.2f%@", arguments: [celsiusFahrenheitConvert(temp: info.main.tempMax), tempUnit.expression])
    }
    
    func minimumTemperatureFormat() -> String {
        return String(format: "%0.2f%@", arguments: [celsiusFahrenheitConvert(temp: info.main.tempMin), tempUnit.expression])
    }
    
    
    private func celsiusFahrenheitConvert(temp: Double) -> Double {
        var convertValue = temp
        if tempUnit == .imperial {
            convertValue = (temp * 1.8) + 32
        }
        
        return convertValue
    }
}
