//
//  InfoViewController.swift
//  Navigation
//
//  Created by Ален Авако on 11.09.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var store = [PeopleModel]()
    
    private let dataFetcher = NetworkDataFetcher()
    
    private let tableView = CitizensTableView()
    
    private var testInfo: TestInfoModel?
    
    private var planetInfo: PlanetModel?
    
    override func loadView() {
        super.loadView()
        
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.citizensTableView.dataSource = self
        
        setLabelValue()
    }
    
    private func setLabelValue() {
        dataFetcher.testInfoFetcher { [weak self] infoModel in
            switch infoModel {
            case .success(let data):
                self?.testInfo = data
                self?.tableView.citizensTableView.reloadData()
            case .failure(let error):
                let alert = CustomAlert.shared.createAlert(title: error.localizedDescription, message: "", style: .alert)
                self?.present(alert, animated: true)
            }
            
        }
        
        dataFetcher.planetInfoFetcher { [weak self] planetModel in
            print(planetModel)
//            self?.planetInfo = planetModel?.result
//            self?.tableView.citizensTableView.reloadData()
//            guard let citizens = planetModel?.result.residents else { return }
//            for (index, value) in citizens.enumerated() {
//                self?.dataFetcher.peopleDataFetcher(person: value) { peopleModel in
//                    guard let human = peopleModel else { return }
//                    self?.store.append(human)
//                    self?.tableView.citizensTableView.reloadData()
//                }
//            }
        }
    }
}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return store.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            if (cell != nil)
            {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                            reuseIdentifier: String(describing: UITableViewCell.self))
            }
            
            cell?.textLabel?.text = testInfo?.title
            cell?.detailTextLabel?.text = "\(String(describing: testInfo?.completed))"
            cell!.selectionStyle = .none
            return cell!
        } else if indexPath.section == 1 {
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
            if (cell != nil)
            {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                            reuseIdentifier: String(describing: UITableViewCell.self))
            }
            
//            cell?.textLabel?.text = planetInfo?.name
//            cell?.detailTextLabel?.text = "Период обращения вокруг звезды: \(planetInfo?.orbitalPeriod ?? "0") дня/дней"
            cell!.selectionStyle = .none
            return cell!
        }
        
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        if (cell != nil)
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                        reuseIdentifier: String(describing: UITableViewCell.self))
        }
        
        cell?.textLabel?.text = store[indexPath.row].name
        cell?.detailTextLabel?.text = "Gender: \(store[indexPath.row].gender), Height: \(store[indexPath.row].height)"
        cell!.selectionStyle = .none
        return cell!
    }
    
    
}
