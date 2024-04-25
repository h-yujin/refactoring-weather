//
//  WeatherForecast - ViewController.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    let viewModel: WeatherViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
        viewModel.process(.getFetchWeather)
    }
    
    
    init(api: WeatherServiceable) {
        viewModel = WeatherViewModel(api: api)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        viewModel.process(.loadView)
        bindingView()
    }
}

extension WeatherViewController {
    
    private func bindingView() {
        view = viewModel.view
        navigationItem.title = viewModel.cityName
        navigationItem.rightBarButtonItem?.title = viewModel.currentUnitTitle
        
        viewModel.didSelectAction = { [weak self] weatherForecastInfo, cityInfo in
            let detailViewController: WeatherDetailViewController = WeatherDetailViewController(
                weatherForecastInfo: weatherForecastInfo,
                cityInfo: cityInfo)
            self?.navigationController?.show(detailViewController, sender: self)
        }
        
        if let errorMessage = viewModel.networkErrorMessage {
            Util.showAlert(viewController: self,
                           title: "오류",
                           message: errorMessage,
                           buttonTitle: "확인")
        }
        
    }
    
    private func initialSetUp() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "화씨",
                                                            image: nil,
                                                            target: viewModel,
                                                            action: #selector(viewModel.changeTempUnit))
        
    }
}
