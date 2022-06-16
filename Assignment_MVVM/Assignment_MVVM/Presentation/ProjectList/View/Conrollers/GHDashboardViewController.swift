//
//  GHDashboardViewController.swift
//  Assignment_MVVM
//
//  Created by Anirudha Kumar on 14/06/22.
//

import UIKit
import Combine

//protocol UpdateUserDataDelegate: AnyObject {
//    func updateUserData(userData: ProjectViewModel?)
//}

class GHDashboardViewController: UIViewController {

    @IBOutlet weak var trendingGHTableView: UITableView!
    @IBOutlet weak var ghSerachBar: UISearchBar!
    
    lazy var projectData = ProjectViewModel()
    var filteredProjectData: [ProjectViewModel]?
    //weak var userDelegate: UpdateUserDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ghSerachBar.delegate = self
        registerCell()
        projectData.delegate = self
        projectData.getTrndingProjectData()
        //projectData.publisher.assign(to: &filteredProjectData)
    }
    
    func registerCell() {
        trendingGHTableView.register(UINib(nibName: "TrendingGHTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingGHTableViewCell")
    }

}

extension GHDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProjectData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = trendingGHTableView.dequeueReusableCell(withIdentifier: "TrendingGHTableViewCell") as? TrendingGHTableViewCell else {return UITableViewCell() }
        tableCell.setupCellData(cellData: filteredProjectData?[indexPath.row])
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProjectDetailViewController") as? ProjectDetailViewController else { return }
        if let data = filteredProjectData?[indexPath.row] {
            detailVC.userData = data
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension GHDashboardViewController: ObservableDelegate {
    
    func getDataResponse(successResponse: [ProjectViewModel]?, error: Error?) {
        self.filteredProjectData = successResponse
        DispatchQueue.main.async { [weak self] in
            self?.trendingGHTableView.reloadData()
        }
    }
    
}

extension GHDashboardViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let allViewModelData = filteredProjectData
        filteredProjectData = searchText.isEmpty ? allViewModelData : filteredProjectData?.filter({$0.name?.contains(searchText.lowercased()) ?? false})
        trendingGHTableView.reloadData()
        filteredProjectData = allViewModelData
    }
}

