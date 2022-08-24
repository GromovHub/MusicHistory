//
//  AppStorageCustomTypeView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/22/22.
//

import SwiftUI

class DataSource: ObservableObject {
    init() {
        if let data = UserDefaults.standard.object(forKey: "dataArray") as? Data {
            if let decoded = try? JSONDecoder().decode([String].self, from: data) {
                myArray = decoded
            } else {
                myArray = ["init error"]
            }
        } else {
            myArray = ["init error"]
        }
        
    }
    private var myArray: [String]
//    @AppStorage("dataArray") var dataArray = Data()
    func getArray() -> [String] {
        guard let data = UserDefaults.standard.object(forKey: "dataArray") as? Data else { return ["user defaults error"] }
        guard let decoded = try? JSONDecoder().decode([String].self, from: data) else { return ["decoding error"] }
        myArray = decoded
        return myArray
    }
    func saveArray() {
        guard let encoded = try? JSONEncoder().encode(myArray) else { return }
//        dataArray = encoded
        UserDefaults.standard.set(encoded, forKey: "dataArray")
    }
    func addElementToArray() {
        myArray.append(String(Int.random(in: 0...100)))
        saveArray()
    }
}

struct AppStorageCustomTypeView: View {
    @StateObject var vm = DataSource()
    @State var array: [String] = ["no elements"]
    var body: some View {
        VStack {
            Button("add element") {
                vm.addElementToArray()
                array = vm.getArray()
            }
            List(array, id: \.self) {
                Text($0)
            }
        }
    }
}

struct AppStorageCistomTypeView_Previews: PreviewProvider {
    static var previews: some View {
        AppStorageCustomTypeView()
    }
}
