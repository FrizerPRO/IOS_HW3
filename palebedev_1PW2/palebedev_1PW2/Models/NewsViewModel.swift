//
//  NewsViewModel.swift
//  palebedev_1PW2
//
//  Created by Frizer on 08.12.2022.
//

import UIKit

final class NewsViewModel:Codable {
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data? = nil
    init(title: String, description: String, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        guard let imageURL = imageURL else {
            return
        }

        URLSession.shared.dataTask(with: imageURL){
            data,response,error in
            self.imageData = data
        }.resume()
    }
}

