//
//  CombineTest.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/28/22.
//

import Foundation
import Combine

class CombineTest {
    class Test {
        static let shared = Test()
        var a = 10
        func combine() {
            Just(9).assign(to: \.a, on: self)
        }
    }
    init() {
        var array = [1,2,3]
            .publisher
            .map { i in
                i + 10
            }
            .filter { i in
                i > 11
            }
        
        var y = array.sink { i in
            print(i)
        }
        
        y.cancel()
        
        var array2 = [10,15,20]
            .publisher
            .map { i in
                i + 100
            }
            .sink { i in
                print(i)
            }
        
        let timer = Timer.publish(every: 1, on: .current, in: .default)
            .autoconnect()
            .sink { Date in
                print(Date)
            }
        
        let z = URLSession.shared.dataTaskPublisher(for: URL(string: "https://picsum.photos/300")!)
            .sink { i in
                print("recieve completion", i)
            } receiveValue: { (data, response) in
                print(data)
            }
        
        
        Test.shared.combine()
        print(Test.shared.a)
        
        
        var b = PassthroughSubject<Int, Never>()
        b.sink { i in print(i) }
        b.send(1001)
        b.send(1000)
        
        var c = CurrentValueSubject<Int, Never>(2000)
        c.send(2001)
        c.send(2002)
        var d : AnyCancellable = c.sink { i in
            print(i)
        }
        c.send(2003)
        
    }
    
}

