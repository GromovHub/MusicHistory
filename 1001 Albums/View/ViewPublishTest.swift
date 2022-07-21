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
        Thread.sleep(forTimeInterval: 0.5)
        await MainActor.run {
            self.results.append(Int.random(in: 0...9999))
            
        }
        
    }
    func addResult2() {
        Task {
            await addResult()
            print("add result 2")
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
        }.task {
            await vm.addResult()
        }
    }
}

struct ViewPublishTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewPublishTest()
    }
}
