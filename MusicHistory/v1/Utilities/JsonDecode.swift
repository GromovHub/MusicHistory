//
//  JsonDecoder.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/9/22.
//

import Foundation

// how to get objects from json file

 fileprivate class JsonDecode {
    var result = [JSON1001]()
    func decode() {
        let fileName = "Dirty1001Object"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("invalid filr path")
            return
        }
        let file = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: file) else {
            print("invalid data")
            return
        }
        do {
            result = try JSONDecoder().decode([JSON1001].self, from: data)
        } catch {
            print(error)
        }
    }
}

