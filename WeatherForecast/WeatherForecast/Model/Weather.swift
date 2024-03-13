//
//  WeatherForecast - Weather.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

// MARK: - Weather JSON Format
class WeatherJSON: Decodable {
    let weatherForecast: [WeatherForecastInfo]
    let city: City
}

// MARK: - List
class WeatherForecastInfo: Decodable {
    let dt: TimeInterval
    let main: MainInfo
    let weather: Weather
    let dtTxt: String
}

// MARK: - MainClass
class MainInfo: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity, pop: Double
}

// MARK: - Weather
class Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    var iconPath : String { get { return "https://openweathermap.org/img/wn/\(icon)@2x.png" }}
}

// MARK: - City
class City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
    let sunrise, sunset: TimeInterval
}

// MARK: - Coord
class Coord: Decodable {
    let lat, lon: Double
}

