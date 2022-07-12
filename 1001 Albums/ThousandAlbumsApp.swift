//
//  1001_AlbumsApp.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 6/16/22.
//

import SwiftUI

@main
struct ThousandAlbumsApp: App {
    let x: Void = ItunesComparator.singleton.getItunesJson()
    var body: some Scene {
        WindowGroup {
            ThousandListView()
            
        }
    }
}
