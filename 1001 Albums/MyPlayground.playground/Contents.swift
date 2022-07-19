import Foundation
import UIKit

func getImagesAsync() async {
    do {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://picsum.photos/200")!)
        print(data)
//        await MainActor.run {
//            print(data)
//        }
    } catch {
        print(error)
    }

}

func getImagesSync() {
    URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/200")!) { data, _, _ in
        print(data!)
    }.resume()
}

Task {
    for i in 0...100 {
        print(i)
        await getImagesAsync()
    }
}



//for i in 0...100 {
//    print(i)
//    getImagesSync()
//}
