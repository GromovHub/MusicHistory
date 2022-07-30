import Combine
import Foundation
class Test100500 {
    static let shared = Test100500()
    init() {
    var url = URL(string: "")!
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .tryMap { (data, resp) in
                    print(data)
            }
            .decode(type: <#T##Decodable.Protocol#>, decoder: <#T##TopLevelDecoder#>)
            .store(in: <#T##Set<Combine.AnyCancellable>#>)
    }
    @Published var vari = 1 {
        didSet {
            print("did", vari)
        }
    }

}
//Test100500()
Test100500.shared

