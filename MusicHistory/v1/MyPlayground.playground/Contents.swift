import Combine
import Foundation

func mytest() {
//guard let x = UserDefaults.standard.data(forKey: <#T##String#>)
//guard let x = UserDefaults.standard.value(forKey: "")
//    do {
//        try UserDefaults.standard.object(forKey: "rgdtf")
//    } catch {
//        print(error)
//    }
    UserDefaults.standard.set([1,2,3], forKey: "rgdtf")
guard let x = UserDefaults.standard.object(forKey: "rgdtf") as? [Int] else {
    print("error")
    return
}
    print(x.self)
}
mytest()
