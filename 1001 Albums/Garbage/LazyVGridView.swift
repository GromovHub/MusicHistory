//
//  LazyVGridView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/24/22.
//

import SwiftUI

struct LazyVGridView: View {
    let fixed: [GridItem] = Array<GridItem>(repeating: .init(.fixed(100), spacing: 1, alignment: .center), count: 3)
    let adaptive: [GridItem] = [.init(.adaptive(minimum: 30, maximum: 500), spacing: 1, alignment: .center)]
    let flex: [GridItem] = [.init(.flexible(minimum: 300, maximum: 500), spacing: 1, alignment: .center), .init(.flexible(minimum: 30, maximum: 100), spacing: 1, alignment: .center)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptive, alignment: .center, spacing: 1, pinnedViews: [.sectionHeaders]) {
                Section(header: Text("content").rotationEffect(.degrees(90)).padding().foregroundColor(.yellow)) {
                    
                    ForEach(0..<10000) { _ in
                        Color(.sRGB, red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), opacity: 1)
                    }
                }
            }
        }.onAppear {
            print("show")
        }
    }
}

struct LazyVGridView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridView()
    }
}
