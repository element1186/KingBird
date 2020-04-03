//
//  DataDownloader.swift
//  KingBird
//
//  Created by Sergey on 30.03.2020.
//  Copyright © 2020 Sergey. All rights reserved.
//

import Alamofire
import Foundation

struct PicsumPhoto: Decodable {
    var author: String?
    var id: String?
    var width: Int?
    var height: Int?
    var url: String?
    var downloadUrl: String?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case id = "id"
        case width
        case height
        case url = "url"
        case downloadUrl = "download_url"
    }

}

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class DataDownloader{
    
    static let shared = DataDownloader()
    private init(){}

    func dataDonwload(page: Int = 1, limit: Int = 20, handler: @escaping (Result<[PicsumPhoto]>) -> Void){
        Alamofire.request("https://picsum.photos/v2/list?page=\(page)&limit=\(limit)").responseJSON { response in
            guard let data = response.data else { return }
            do {
                let dataArray = try JSONDecoder().decode([PicsumPhoto].self, from: data)
                handler(.success(dataArray))
            } catch let error{
                handler(.failure(error))
            }
        }
    }
    
}
