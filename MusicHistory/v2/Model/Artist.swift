//
//  Artist.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation

struct Artist: Codable, Identifiable {
    let id: Int
    var artist: String
    let album: String
    let date: Int
    var listened: Bool
}
