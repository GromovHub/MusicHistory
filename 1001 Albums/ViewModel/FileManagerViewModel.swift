//
//  FileManagerViewModel.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/9/22.
//

import Foundation
import UIKit

class FileManagerViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    var imageName = "dog"
    init() {
        getImageFromAssets()
    }
    func getImageFromAssets() {
        image = UIImage(named: imageName)
    }
    func changeName(name: String) {
        imageName = name
    }
    
}
