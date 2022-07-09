import Foundation
var result = [JSON1001]()
func decode() {
    let fileName1 = "json1001raw"
    let fileName2 = "simpleObj"
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
        try JSONDecoder().decode([JSON1001].self, from: data)
    } catch {
        print(error)
    }
//    result = dataObj
}

decode()
