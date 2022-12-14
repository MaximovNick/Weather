//
//  CityWeatherDetailViewController.swift
//  Weather
//
//  Created by Nikolai Maksimov on 12.12.2022.
//

import UIKit

final class CityWeatherDetailViewController: UIViewController {
    
    // MARK: - Public Properties
    var detailWeatherInfo: Weather!
    
    // MARK: -  Private Properties
    private lazy var titleLabel = getLabel(
        font: .boldSystemFont(ofSize: 32),
        textColor: .white,
        alignment: .center)
    
    private lazy var temperatureLabel = getLabel(
        font: .boldSystemFont(ofSize: 50),
        textColor: .red,
        alignment: .center
    )
    
    private lazy var conditionLabel = getLabel(
        font: .boldSystemFont(ofSize: 24),
        textColor: .white,
        alignment: .center
    )
    
    private lazy var minMaxTempLabel = getLabel(
        font: .systemFont(ofSize: 22),
        textColor: .white,
        alignment: .center
    )
    
    private lazy var weatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel = getLabel(
        font: .boldSystemFont(ofSize: 22),
        textColor: .white,
        alignment: .center
    )
    
    private lazy var firstBachgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 255/255, green: 114/255, blue: 96/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secondBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 255/255, green: 114/255, blue: 96/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backButton: UIButton = {
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 20)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.attributedTitle = AttributedString("На главную", attributes: attributes)
        
        return UIButton(configuration: buttonConfiguration, primaryAction: UIAction { _ in
            self.dismiss(animated: true)
        })
    }()
    
    private lazy var tempImage: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
        setConstraints()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func addSubview() {
        view.addSubview(firstBachgroundView)
        [titleLabel,temperatureLabel,
         conditionLabel, minMaxTempLabel].forEach { firstBachgroundView.addSubview($0) }
        
        view.addSubview(secondBackgroundView)
        [weatherImageView,
         descriptionLabel,
         backButton].forEach { secondBackgroundView.addSubview($0) }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        titleLabel.text = detailWeatherInfo.cityName
        temperatureLabel.text = "\(detailWeatherInfo.weather.fact.temp)º"
        conditionLabel.text = detailWeatherInfo.condition
        minMaxTempLabel.text = "Макс.:\(detailWeatherInfo.weather.forecasts.first?.parts.day.tempMax ?? 0),"+" "+"мин.:\(detailWeatherInfo.weather.forecasts.first?.parts.day.tempMin ?? 0)"
        descriptionLabel.text = detailWeatherInfo.description
        weatherImageView.image = UIImage(named: getCurrentWeatherImage())
    }
}

// MARK: - Condition image
extension CityWeatherDetailViewController {
    private func getCurrentWeatherImage() -> String {
        var condition = ""
        
        switch conditionLabel.text {
        case "Ясно":                                    condition = "clear"
        case "Малооблачно", "Облачно с прояснениями":   condition = "cloudy"
        case "Пасмурно":                                condition = "cloudy-2"
        case "Морось", "Небольшой дождь", "Дождь",
            "Умеренно сильный дождь", "Сильный дождь",
            "Длительный сильный дождь", "Ливень":       condition = "drizzle"
        case "Дождь со снегом":                         condition = "rainSnow"
        case "Небольшой снег", "Снег", "Снегопад":      condition = "snowy"
        case "Град", "Гроза":                           condition = "thunderstorm"
        case "Дождь с грозой", "Гроза с градом":        condition = "storm-2"
            
        default:
            return ""
        }
        return condition
    }
}

// MARK: - Label Settings
extension CityWeatherDetailViewController {
    
    private func getLabel(font: UIFont, textColor: UIColor, alignment: NSTextAlignment ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

// MARK: - Subviews & Constraints
extension CityWeatherDetailViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            firstBachgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            firstBachgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            firstBachgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            firstBachgroundView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: firstBachgroundView.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: firstBachgroundView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: firstBachgroundView.centerXAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            conditionLabel.centerXAnchor.constraint(equalTo: firstBachgroundView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            minMaxTempLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 7),
            minMaxTempLabel.centerXAnchor.constraint(equalTo: firstBachgroundView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            secondBackgroundView.topAnchor.constraint(equalTo: firstBachgroundView.bottomAnchor, constant: 20),
            secondBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            secondBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: secondBackgroundView.topAnchor, constant: 10),
            weatherImageView.widthAnchor.constraint(equalToConstant: 200),
            weatherImageView.heightAnchor.constraint(equalToConstant: 200),
            weatherImageView.centerXAnchor.constraint(equalTo: secondBackgroundView.centerXAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: secondBackgroundView.bottomAnchor, constant: -20),
            backButton.centerXAnchor.constraint(equalTo: secondBackgroundView.centerXAnchor),
            backButton.leadingAnchor.constraint(equalTo: secondBackgroundView.leadingAnchor, constant: 20),
            backButton.trailingAnchor.constraint(equalTo: secondBackgroundView.trailingAnchor, constant: -20),
        ])
    }
}


