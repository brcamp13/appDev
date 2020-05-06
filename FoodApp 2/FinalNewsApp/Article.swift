//
//  Article.swift
//  FinalNewsApp
//
//  Created by Brandon Campbell on 5/3/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import Foundation

class Article {
    var author: String?
    var title: String?
    var imageUrl: String?
    var articleUrl: String?
    var id: String?
    var publishedAt: Date?

    init(author: String, title: String, imageUrl: String, articleUrl: String, publishedAt: Date) {
        self.author = author
        self.title = title
        self.imageUrl = imageUrl
        self.articleUrl = articleUrl
        self.id = UUID().uuidString
        self.publishedAt = publishedAt
    }
}
