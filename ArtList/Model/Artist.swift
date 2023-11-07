//
//  Author.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import Foundation

struct Artist {
    var artists: [Author]
}

struct Author {
    var name: String
    var bio: String
    var image: String
    var works: [Work]
}

struct Work {
    var title: String
    var image: String
    var info: String
}
