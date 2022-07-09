//
//  jsonDecode.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/9/22.
//

import Foundation

 fileprivate struct example1 {
    var result = [JSON1001]()
    func decode() {
        let fileName1 = "json1001raw"
//        let fileName2 = "simpleObj"
        guard let path = Bundle.main.path(forResource: fileName1, ofType: "json") else {
            print("invalid filr path")
            return
        }
        let file = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: file) else {
            print("invalid data")
            return
        }
    //    guard let dataObj = (try? JSONDecoder().decode([JSON1001].self, from: data)) else {
    //        print("invalid decode")
    //        return
    //    }
        do {
            let temp = try JSONDecoder().decode([JSON1001].self, from: data)
            print(temp, data)
        } catch {
            print(error)
        }
    //    result = dataObj
    }
}

