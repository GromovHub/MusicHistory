//
//  AsyncLet.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/22/22.
//

import Foundation

class AsyncLet {
    init () {}
    static let shared = AsyncLet()
    
    var result: [Int] = [] {
        didSet {
            print(self.result)
        }
    }
    
    func asyncHello() async {
        Thread.sleep(forTimeInterval: 1)
        let x = Int.random(in: 0...100)
        print("async hello", x)
    }
    
    func asyncInt() async -> Int {
        let x = Int.random(in: 0...9999)
        Thread.sleep(forTimeInterval: TimeInterval(Int.random(in: 0...5)))
        print("asyncInt executed")
        return x
    }
    func asyncCall() {
        Task {
            async let x = asyncInt()
            async let y = asyncInt()
            let (a,b) = await (x,y)
            result.append(contentsOf: [a,b])
        }

//        Task {
//            let x = await asyncInt()
//            result.append(x)
//            let y = await asyncInt()
//            result.append(y)
//        }
    }
}
