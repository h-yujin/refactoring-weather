//
//  WeatherView.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/17/24.
//

import UIKit

protocol WeatherViewDelegate {
    func presentWeatherDetail(weatherForecastInfo: WeatherForecastInfo?, cityInfo: City?)
}

final class WeatherView: UIView {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "WeatherCell")
        return tableView
    }()
    
    private var weatherForecast: [WeatherForecastInfo]?
    private var cityInfo: City?
    let delegate: WeatherViewDelegate
    
    init(delegate: WeatherViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        layoutView()
        setTableView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea: UILayoutGuide = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func setTableViewRefreshControl(refreshControl: UIRefreshControl) {
        tableView.refreshControl = refreshControl
    }
    
    func tableViewReloadData(with weatherJSON: WeatherJSON) {
        weatherForecast = weatherJSON.weatherForecast
        cityInfo = weatherJSON.city
        tableView.reloadData()
    }
}

extension WeatherView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherForecast?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        
        guard let cell: WeatherTableViewCell = cell as? WeatherTableViewCell,
              let weatherForecastInfo = weatherForecast?[indexPath.row] else {
            return cell
        }
        
        cell.updateCell(with: weatherForecastInfo)
        
        return cell
    }
}

extension WeatherView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate.presentWeatherDetail(weatherForecastInfo: weatherForecast?[indexPath.row],
                                      cityInfo: cityInfo)
    }
}


