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
        Thread.sleep(forTimeInterval: 0.3)
        let x = Int.random(in: 0...100)
        print("async hello", x)
    }
    
    func asyncInt() async -> Int {
        let x = Int.random(in: 0...9999)
        Thread.sleep(forTimeInterval: TimeInterval(Int.random(in: 0...5)))
        print("asyncInt executed")
        return x
    }
    
    func taskGroup() async {
        await withTaskGroup(of: Int.self) { group in
            for i in 0...10 {
                group.addTask {
                    let x = await self.asyncInt()
                    print("task", i, "with", x)
                    return x
                }
                for await j in group {
                    result.append(j)
                }
                
            }
        }
    }
    
    func asyncCall() {
//        Task {
//
//            async let x = asyncInt()
//            async let y = asyncInt()
//            let (a,b) = await (x,y)
//            result.append(contentsOf: [a,b])
//        }

//        Task {
//            let x = await asyncInt()
//            result.append(x)
//            let y = await asyncInt()
//            result.append(y)
//        }
    
        Task {
            await taskGroup()
        }
        
    }
}
