//
//  CityListTableViewCell.swift
//  Weather
//
//  Created by Nikolai Maksimov on 12.12.2022.
//

import UIKit

final class CityListTableViewCell: UITableViewCell {
    
    static let identifier = "CityListTableViewCell"
    
    // MARK: - Private propertise
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "thermometer.high")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .right
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemMint
        view.layer.borderWidth = 2
        view.layer.borderColor = CGColor(red: 255/255, green: 114/255, blue: 96/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(customView)
        [cityNameLabel, tempLabel, tempImageView].forEach { customView.addSubview($0) }
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(weather: Weather) {
        cityNameLabel.text = weather.cityName
        tempLabel.text = "\(weather.weather.fact.temp)º"
        conditionLabel.text = "\(weather.condition)"
    }
}

// MARK: - Constraints
extension CityListTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            customView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            customView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            customView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            cityNameLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tempImageView.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: 0),
            tempImageView.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),
            tempLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            tempLabel.widthAnchor.constraint(equalToConstant: 45),
        ])
    }
}

