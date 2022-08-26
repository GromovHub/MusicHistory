//
//  1001_AlbumsApp.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 6/16/22.
//

import SwiftUI

@main
struct ThousandAlbumsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
//            userdef()
                .onAppear {
        #if DEBUG
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        #endif
                }
            
        }
        
    }
    
}

