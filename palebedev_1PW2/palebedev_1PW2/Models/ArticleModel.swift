//
//  ArticleModel.swift
//  palebedev_1PW2
//
//  Created by Frizer on 09.12.2022.
//

import Foundation
final class APIResponse: Codable{
    let articles: [Article]
}
final class Article:Codable {
    let title: String
    let description: String?
    let urlToImage: String?
}
