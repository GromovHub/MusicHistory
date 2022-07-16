import Foundation
import Darwin
var flag: Bool = false
let url = URL(string: "https://itunes.apple.com/search?entity=album&term=haircut+100+pelican+west")!
let publisher = URLSession.shared.dataTaskPublisher(for: url)
    
    
var x = publisher.sink(
    receiveCompletion: { completion in
        // Called once, when the publisher was completed.
        flag = true
        print("------")
        print(completion)
        print("-------")
    },
    receiveValue: { value in
        // Can be called multiple times, each time that a
        // new value was emitted by the publisher.
        print(String(decoding: value.data, as: UTF8.self))
        flag = true
    }
)
Thread.sleep(forTimeInterval: 0.5)
print(flag)


