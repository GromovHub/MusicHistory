import Foundation
import _Concurrency

class ClassWithAsyncFunc: ObservableObject {
    // создай длинный список, который постепенно подгружается
    init() {print("object init")}
    deinit {print("object deinit")}
    @Published var results: [Int] = []
    func getImagesAsync(id: Int) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://picsum.photos/200")!)
            print(id, data)
    //        await MainActor.run {
    //            print(data)
    //        }
        } catch {
            print(error)
        }
    }
}



func getImagesSync(id: Int) {
    URLSession.shared.dataTask(with: URL(string: "https://picsum.photos/200")!) { data, _, _ in
        print(id, data!)
    }.resume()
}

//Task {
//    for i in 0...100 {
//        print(i)
//        await getImagesAsync(id: i)
//    }
//}

func funcWithTask1() {
print("func started")
    for i in 0...10 {
        print(i, "before task")
        Task {
            let x = ClassWithAsyncFunc()
            await x.getImagesAsync(id: i)
        }
        print(i, "after task")
    }
print("func end")
}
func runPreview() { print("run preview") }
func showData() { print("show data") }

func funcWithTask2() {
    
    Task {
        let x = ClassWithAsyncFunc()
        var array: [Int] = []
        runPreview()
        for i in 0...10 {
            await x.getImagesAsync(id: i)
            array.append(i)
            x.results.append(i)
        }
        showData()
    }
}

funcWithTask2()
//for i in 0...100 {
//    print(i)
//    getImagesSync(id: i)
//}
