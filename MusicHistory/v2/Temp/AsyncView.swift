//
//  AsyncView.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/23/22.
//

import SwiftUI

struct AsyncView: View {
    @State private var name = "welcome"
    
    var body: some View {
        ScrollView {
            Button("get") {
                Task {
                    await getAsync()
                }
            }
            
            Text("Data")
                .font(.largeTitle)
            switch name {
            case "":
                ProgressView()
            case "welcome":
                Text(name).font(.headline)
            default:
                Text(name)
            }
        }
//        .task {
//            await getAsync()
//        }
    }
    
    func getAsync() async {
        name = ""
        print("get start")
//        Thread.sleep(forTimeInterval: TimeInterval(Double.random(in: 0...3)))
        Thread.sleep(forTimeInterval: 3)
        guard let (data, resp) = try? await URLSession.shared.data(from: URL(string: "https://v2.jokeapi.dev/joke/Any?safe-mode")!) else {
            name = "error"
            return}
        name = "\(String(decoding: data, as: UTF8.self))\n\(resp.description)"
        print("get end")
    }
}

struct AsyncView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncView()
    }
}
