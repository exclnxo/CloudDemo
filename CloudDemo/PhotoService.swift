//
//  PhotoTarget.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import Foundation
import Moya

enum photoService {
    case fetchPhoto
    case downloadImage(url: String)
}

extension photoService : TargetType {
    var baseURL: URL {
        switch self {
        case .fetchPhoto:
            return URL.init(string: "https://jsonplaceholder.typicode.com")!
        case .downloadImage(let url):
            return URL.init(string: url)!
        }
    }
    
    var path: String {
        switch self {
        case .fetchPhoto:
            return "/photos"
        case .downloadImage(_):
            return ""
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    

}
