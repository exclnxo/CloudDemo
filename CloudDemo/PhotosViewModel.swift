//
//  PhotosViewModel.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import UIKit
import Moya

class PhotosViewModel {
    var cellViewModels: [photoModel] = [photoModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?
    let provider = MoyaProvider<photoService>()
    var apiService: APIServiceProtocol
    
    var numberOfCells: Int {
        return cellViewModels.count
      }
    
    func getCellViewModel(_ indexPath: IndexPath ) -> photoModel {
        return cellViewModels[indexPath.item]
    }
    
    func fetchPhoto() {
        isLoading = true
        self.apiService.fetchPhoto { [weak self] success, photos in
            self?.isLoading = false
            self?.cellViewModels = photos ?? [photoModel]()
        }
    }
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        fetchPhoto()
    }
}
