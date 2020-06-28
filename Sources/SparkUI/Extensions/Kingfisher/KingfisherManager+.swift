//
//  KingfisherManager+.swift
//  
//
//  Created by Alex Nagy on 28/06/2020.
//

import Foundation
import UIKit
import Kingfisher

public extension KingfisherManager {
    static func downloadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        let downloader = ImageDownloader.default
        downloader.downloadImage(with: url) { result in
            switch result {
            case .success(let value):
                completion(.success(value.image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
