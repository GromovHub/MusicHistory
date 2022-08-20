//
//  Artist.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 8/20/22.
//

import Foundation

struct Artist: Codable, Identifiable {
    let id: Int
    let artist: String
    let album: String
    let date: Int
    let listened: Bool
}
