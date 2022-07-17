//
//  TestView1.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/17/22.
//

import SwiftUI

class JSONManager {
    func getClassicObjects() throws -> [Classic1001Object2] {
        guard let file = Bundle.main.url(forResource: "Classic1001ObjectAfterLoop2", withExtension: "json") else {
            throw URLError(.badURL)
        }
        guard let data = try? Data(contentsOf: file) else {
            throw URLError(.cannotDecodeContentData)
        }
        var results = [Classic1001Object2]()
        do {
             results = try JSONDecoder().decode([Classic1001Object2].self, from: data)
        } catch {
            print(error)
        }
        return results
//        if let objects = try? JSONDecoder().decode([Classic1001Object].self, from: data) {
//            return objects
//        } else {
//            print("decoder manager failed")
//            throw URLError(.cannotDecodeRawData)
//        }
    }
}

class TestViewViewModel: ObservableObject {
    @Published var jsonManager = JSONManager()
    func fetchClassicObjects() -> [Classic1001Object2] {
        if let objects = try? jsonManager.getClassicObjects() {
            return objects
        } else {
            return [Classic1001Object2(id: 0, artist: "fail", album: "fail", date: 0, url: ["fail"], listened: false, compareProblem: false)]
        }
    }
}

struct TestView1: View {
    @StateObject var vm = TestViewViewModel()
    @State var sheetFlag = false
    @State var color1 = Color.green
    @State var color2 = Color.red
    @State var color3 = Color.yellow
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.fetchClassicObjects()) { i in
                    VStack() {
                        Text("№ \(i.id)")
                        Text(i.artist).font(Font.title)
                        Text(i.album)
                        Text("\(String(i.date))")
                        Text("listened: \(String(i.listened))")
                            .foregroundColor(i.listened ? color1 : color3)
                    
                        
                        Text("compare problem: \(String(i.compareProblem))")
                        
                        NavigationLink {
                            editorView(urls: i.url)
                        } label: {
                            Text("Click to show urls")
                                .foregroundColor((i.url.isEmpty) || (i.url.first! == "no results") ? color2 : Color.blue)
                                .font(.headline)
                        }.buttonStyle(.bordered)
                    }.onTapGesture {
                        print("\(i.id)")
                    }
                }
            }.navigationTitle("Albums")
        }
    }
}

struct editorView: View {
    var urls = [String]()
    init(urls: [String]) {
        self.urls = urls
    }
    var body: some View {
        List {
            if urls.count == 0 {
                Text("empty array")
            } else {
                ForEach(urls, id: \.self) { k in
                    if k == "no results"{
                        Text("no results")
                    } else {
                        Text(k)
                        Link("open", destination: URL(string: k)!)
                    }
                    
                }
            }
        }
    }
}
struct TestView1_Previews: PreviewProvider {
    static var previews: some View {
        TestView1()
    }
}
