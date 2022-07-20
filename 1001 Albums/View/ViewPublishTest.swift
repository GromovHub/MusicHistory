//
//  ViewPublishTest.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/20/22.
//

import SwiftUI
class PublishTest: ObservableObject {
    @Published var results = [Int]()
    func addResult() async {
            self.results.append(Int.random(in: 0...9999))
            sleep(1)
    }
    func addResult2() {
        Task {
            await addResult()
        }
    }
}

struct ViewPublishTest: View {
    @StateObject var vm = PublishTest()
    var body: some View {
        VStack {
            Button("add row") {
                vm.addResult2()
            }
            List {
                ForEach(vm.results, id: \.self) { i in
                    Text("\(i)")
                }
            }
        }
    }
}

struct ViewPublishTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewPublishTest()
    }
}
