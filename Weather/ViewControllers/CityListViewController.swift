//
//  CityListViewController.swift
//  Weather
//
//  Created by Nikolai Maksimov on 12.12.2022.
//

import UIKit

final class CityListViewController: UIViewController {
   
    // MARK: -  Private Properties
    private let tableView = UITableView()
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var filteredCities: [Weather] = []
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private var currentCities: [Weather] = []
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Список городов"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupSearchController()
        setConstraints()
        fetchWeatherInfo()
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewCity)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - Private methods
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.register(CityListTableViewCell.self, forCellReuseIdentifier: CityListTableViewCell.identifier)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func fetchWeatherInfo() {
        CityWeatherManager.shared.getCitiesWeather() { weather in
            for i in weather {
                self.currentCities.append(i)
            }
            self.tableView.reloadData()
        }
    }
    
    @objc private func addNewCity() {
        showAlert()
    }
}

//MARK: - UISearchResultsUpdating
extension CityListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredCities = currentCities.filter {
            $0.cityName.contains(searchText)
        }
        tableView.reloadData()
    }
}

// MARK: - Alert Controller
extension CityListViewController {
    
    private func showAlert() {
        let alert = UIAlertController(title: "", message: "Введите название города", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let textFieldText = alert.textFields?.first?.text else { return }
            guard !textFieldText.isEmpty else { return }
            self.saveCity(withName: textFieldText)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true)
        
        alert.addTextField { textField in
            textField.placeholder = "Название города"
            textField.autocapitalizationType = .words
        }
    }
    
    private func saveCity(withName name: String) {
        CityWeatherManager.shared.getCityWeather(city: name) { weather in
            self.currentCities.append(Weather(cityName: weather.cityName, weather: weather.weather))
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension CityListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCities.count
        }
        return currentCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityListTableViewCell.identifier, for: indexPath) as? CityListTableViewCell else { return UITableViewCell() }
        
        var weather: Weather!
        
        if isFiltering {
            weather = filteredCities[indexPath.row]
        } else {
            weather = currentCities[indexPath.row]
        }
    
        cell.configure(weather: weather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") { _, _, _ in
            self.currentCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    
        deleteAction.image = UIImage(named: "remove")
        deleteAction.backgroundColor = .systemBackground

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UITableViewDelegate
extension CityListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var weather: Weather!
        
        if isFiltering {
            weather = filteredCities[indexPath.row]
        } else {
            weather = currentCities[indexPath.row]
        }
    
        let detailVC = CityWeatherDetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.detailWeatherInfo = weather
        present(detailVC, animated: true)
    }
}

// MARK: - Constraints
extension CityListViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
}
