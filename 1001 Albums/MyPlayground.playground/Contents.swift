import _Concurrency
import Foundation

//AsyncLet.shared.asyncCall()

class TestContinuations {
    
    init() {}
    static let shared = TestContinuations()
    
    var result: [Data] = [] {
        didSet {
            print(self.result)
        }
    }
    
    func getDataClassic() {
        URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/300")!) { data, resp, err in
            if let data = data {
                self.result.append(data)
//                print(data)
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

    
}

for i in 0...10 {
    Task {
        print(i)
        let x = await TestContinuations.shared.getDataContinuation()
        TestContinuations.shared.result.append(x)
    }
   
   
}

