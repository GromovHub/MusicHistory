//
//  TabViewTest.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/26/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Color.pink.ignoresSafeArea().opacity(0.3)
    }
}
struct SecondView: View {
    var body: some View {
        Color.cyan.opacity(0.3).ignoresSafeArea()
    }
}

struct TabViewTest: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SecondView()
                .tabItem {
                    Label("Second", systemImage: "book")
                }
        }
    }
}

struct TabViewTest_Previews: PreviewProvider {
    static var previews: some View {
        TabViewTest()
    }
}
