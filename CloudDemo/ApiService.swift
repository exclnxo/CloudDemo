//
//  ApiService.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import Foundation
import Moya

protocol APIServiceProtocol {
    func fetchPhoto(complete: @escaping (_ success: Bool, _ photos: [photoModel]?) -> ())
}

class ApiService: APIServiceProtocol {
    
    let provider = MoyaProvider<photoService>()
    
    func fetchPhoto(complete: @escaping (_ success: Bool, _ photos: [photoModel]?) -> ()) {
        provider.request(.fetchPhoto) { (result) in
            switch result {
            case let .success(response):
                do {
                    let model = try JSONDecoder().decode([photoModel].self, from: response.data)
                    complete(true, model)
                } catch let error {
                    print("error: \(error)")
                    complete(true, nil)
                }
                
            case .failure(_):
                complete(false, nil)
            }
        }
    }

}
