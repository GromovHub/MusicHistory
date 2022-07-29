import Foundation

//{
//    didSet {
//        print(array)
//    }
//}
class Playground777 {
    init() {
       
    }
    var array: [Int] = []
    static let shared = Playground777()
    let timer = Timer.publish(every: 0.1, on: .main, in: .default)
        .autoconnect()
        .sink { date in
            print(date)
//                print(array)
        }
        
    func appenToArray() {
        for i in 1...10 {
            Thread.sleep(forTimeInterval: 1)
            array.append(i)
        }
    }
    func appendOne() {
        Thread.sleep(forTimeInterval: 1.0)
        array.append(Int.random(in: 0...100))
    }
//    func play() {
//        timer
//            .autoconnect()
//            .sink { date in
//                print(date)
////                print(array)
//            }
//
//    }
}

var x = Playground777()
x.timer.autoconnect()
