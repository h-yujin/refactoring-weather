//
//  WeatherDetailViewModel.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/25/24.
//

import Foundation

final class WeatherDetailViewModel: ObservableObject {
    enum Action {
        case loadView
    }
    
    private let weatherForecastInfo: WeatherForecastInfo
    private let cityInfo: City
    @Published var view: WeatherDetailView?
    @Published var weatherDateString: String?
    
    init(weatherForecastInfo: WeatherForecastInfo, 
         cityInfo: City) {
        self.weatherForecastInfo = weatherForecastInfo
        self.cityInfo = cityInfo
    }
    
    func process(_ action: Action) {
        switch action {
        case .loadView:
            loadView()
            getWeatherDateString()
        }
    }
    
    
}

extension WeatherDetailViewModel {
    private func loadView() {
        view = WeatherDetailView(weatherForecastInfo: weatherForecastInfo,
                                 cityInfo: cityInfo)
        
    }
    
    private func getWeatherDateString() {
        let date: Date = Date(timeIntervalSince1970: weatherForecastInfo.dt)
        weatherDateString = date.toWeatherDateString
    }
}
