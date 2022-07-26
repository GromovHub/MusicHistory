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
            var tempArray = [Int]()
            for i in 0...10 {
                group.addTask {
                    let x = await self.asyncInt()
                    print("task", i, "with", x)
                    return x
                }
                for await j in group {
                    tempArray.append(j)
                }
            }
            result.append(contentsOf: tempArray)
        }
    }
    
    func getDataClassic() {
        URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/300")!) { data, resp, err in
            if let data = data {
//                self.result.append(data)
                print(data)
            } else {
                print("let data error")
            }
        }.resume()
    }
    
    func getDataContinuation() async -> Data {
        return await withCheckedContinuation { cont in
            URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/300")!) { data, resp, err in
                if let data = data {
                    cont.resume(returning: data)
                    
                }
            }.resume()
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
    
    func printHello(sec: Int) async {
        sleep(UInt32(sec))
        print("printed", sec)
    }
    func callLet() {
        Task {
//            async let x = await printHello(sec: 3)
//            async let y = await printHello(sec: 1)
//            let (x1,x2) = await (x,y)
            
            await withTaskGroup(of: Void.self, body: { group in
                group.addTask {
                    await self.printHello(sec: 5)
                }
                group.addTask {
                    await self.printHello(sec: 1)
                }
            })
        }
        
       


    }
}
