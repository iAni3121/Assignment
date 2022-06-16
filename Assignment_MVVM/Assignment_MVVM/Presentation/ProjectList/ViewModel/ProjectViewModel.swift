//
//  ProjectViewModel.swift
//  Assignment_MVVM
//
//  Created by Anirudha Kumar on 14/06/22.
//

import Foundation
import UIKit

protocol ObservableDelegate {
    func getDataResponse(successResponse: [ProjectViewModel]?, error: Error?)
}

extension Notification.Name {
 static let updateData = Notification.Name("ObserveViewModelData")
}

struct ProjectViewModel {
    
    var delegate: ObservableDelegate?
    var projectModelData: [ProjectModel]?
    var id: Int?
    var nodeId: String?
    var name: String?
    var fullName: String?
    var isPrivate: Bool?
    var description: String?
    var isFork: Bool?
    var forkUrl: String?
    var owner: Owner?
    var imageData: Data?
//    let publisher = NotificationCenter.Publisher(center: .default, name: .updateData, object: nil).map { (notification)-> [ProjectViewModel]? in
//        return notification.object as? [ProjectViewModel]
//    }
    init() {}
    
    init(data: ProjectModel?) {
        
        self.id = data?.id
        self.nodeId = data?.nodeId
        self.name = data?.name
        self.fullName = data?.fullName
        self.isPrivate = data?.isPrivate
        self.isFork = data?.isFork
        self.description = data?.description
        self.forkUrl = data?.forkUrl
        self.owner = data?.owner
    }
    
    func getTrndingProjectData() {
        
        let repoUrl = StringConstant.gitHubBaseUrl + "repositories"
        
        APIManager.sharedInstance.getDataFromServer(urlString: repoUrl) { data, error in
            if error == nil {
                guard let responseData = data else { return }
                let projectData = try? JSONDecoder().decode([ProjectModel].self, from: responseData)
                let viewDataModel = projectData?.map({ProjectViewModel(data: $0)})
                //NotificationCenter.default.post(name: .updateData, object: viewDataModel)
                delegate?.getDataResponse(successResponse: viewDataModel, error: nil)
            } else {
                delegate?.getDataResponse(successResponse: nil, error: error)
            }
        }
    }
    
    func getProfileImage(urlString: String)-> Data? {
        
        guard let imageUrl = URL(string: urlString) else { return nil }
        let data = try? Data(contentsOf: imageUrl)
        return data
    }
    
}
