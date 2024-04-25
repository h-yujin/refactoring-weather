//
//  WeatherForecast - WeatherDetailViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class WeatherDetailViewController: UIViewController {
    
    let viewModel: WeatherDetailViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    override func loadView() {
        bindingView()
        viewModel.process(.loadView)
    }
    
    init(weatherForecastInfo: WeatherForecastInfo,
         cityInfo: City) {
        viewModel = WeatherDetailViewModel(weatherForecastInfo: weatherForecastInfo,
                                           cityInfo: cityInfo)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialSetUp() {
        view.backgroundColor = .white
    }
    
    private func bindingView() {
        view = viewModel.view
        navigationItem.title = viewModel.weatherDateString
    }
}
