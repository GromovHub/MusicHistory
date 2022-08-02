//
//  CompletionHandler.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/18/22.
//

import Foundation
import QuartzCore

 class CompletionHandler {
    init() {
        getImages { cdata, cid in
            self.appendDataFunc(data: cdata, id: cid)
        }
    }
    static let shared = CompletionHandler()
    
    var results = [Int : Data]()
    
    
    func appendDataFunc(data: Data, id: Int) -> () {
        results[id] = data
        print("id \(id) completed \(data)")
    }
    
    func getImages(completionHandler: @escaping (_ cdata: Data, _ cid: Int) -> ()) {
        for i in 0...10 {
            URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/200")!) { data, resp, err in
                guard let data = data else {
                    return
                }
                completionHandler(data, i)
            }.resume()
        }
       
    }
     
     func call() {
      
             print("start")
             getImages { cdata, cid in
                 self.appendDataFunc(data: cdata, id: cid)
             }

         while(results.count < 10) {
             Thread.sleep(forTimeInterval: 0.1)
             print("wait")
         }
         
         print("results -> \(results.count)")
         return

     }
    
}
