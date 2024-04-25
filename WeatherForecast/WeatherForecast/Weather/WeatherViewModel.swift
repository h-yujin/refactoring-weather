//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Hong yujin on 4/25/24.
//

import UIKit

final class WeatherViewModel: ObservableObject {
    enum Action {
        case loadView
        case getFetchWeather
        case refresh
    }

    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    @Published var view: WeatherView?
    @Published var cityName: String?
    @Published var currentUnitTitle: String?
    
    @Published var didSelectAction: ((WeatherForecastInfo, City) -> Void)?
    @Published var networkErrorMessage: String?
    
    
    private var api: WeatherServiceable
   
    init(api: WeatherServiceable) {
        self.api = api
    }
    
    func process(_ action: Action) {
        switch action {
        case .loadView:
            loadView()
        case .getFetchWeather:
            Task { await fetchWeatherAPI() }
        case .refresh:
            refresh()
        }
    }
    
    
}


extension WeatherViewModel {
    private func loadView() {
        view = WeatherView(delegate: self)
        
        refreshControl.addTarget(self,
                                 action: #selector(refresh),
                                 for: .valueChanged)
        
        view?.setTableViewRefreshControl(refreshControl: refreshControl)
    }
    
    
    private func fetchWeatherAPI() async {
        do {
            let weatherJSON = try await api.fetchWeatherJSON()
            await view?.tableViewReloadData(with: weatherJSON)
            
            cityName = weatherJSON.city.name
        } catch {
            let error = error as? NetworkError
            let errorMessage: String
            switch error {
            case .responesError:
                errorMessage = "응답 처리 중 오류가 발생했습니다."
            case .decodeError:
                errorMessage = "데이터 처리 중 오류가 발생했습니다."
            case nil:
                errorMessage = "알 수 없는 오류가 발생했습니다."
            }

            networkErrorMessage = errorMessage
        }
    }
    
    
    @objc func refresh() {
        Task { await fetchWeatherAPI() }
        
        refreshControl.endRefreshing()
    }
    
    @objc func changeTempUnit() {
        TempUnitManager.shared.changeTempUnit()
        currentUnitTitle = TempUnitManager.shared.currentUnit.title
        refresh()
    }
}


extension WeatherViewModel: WeatherView.Delegate {
    func didSelectRowAt(weatherForecastInfo: WeatherForecastInfo, cityInfo: City) {
        didSelectAction?(weatherForecastInfo, cityInfo)
    }
}
