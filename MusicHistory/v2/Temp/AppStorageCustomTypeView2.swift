//
//  AppStorageCistomTypeView2.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/22/22.
//

import SwiftUI

class AppStorageCistomTypeViewModel: ObservableObject {
    @Published var array = [String]()
}

struct AppStorageCustomTypeView2: View {
    @StateObject var vm = AppStorageCistomTypeViewModel()
    @AppStorage("myStorage") var storage = Data()
    var body: some View {
        VStack {
            Button("append to vm array") {
                vm.array.append(String(Int.random(in: 0...100)))
                print("vm.array.append")
                saveToAppStorage()
            }
            List(vm.array, id: \.self) {
              Text($0)
            }
        }
        .onAppear {
            loadFromAppStorage()
        }
    }
    
    func loadFromAppStorage() {
        guard let data = try? JSONDecoder().decode([String].self, from: storage) else { return }
        vm.array = data
        print("loadFromAppStorage")
    }
    func saveToAppStorage() {
        guard let data = try? JSONEncoder().encode(vm.array) else { return }
        storage = data
        print("saveToAppStorage")
    }
}

struct AppStorageCistomTypeView2_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageCustomTypeView2()
    }
}
