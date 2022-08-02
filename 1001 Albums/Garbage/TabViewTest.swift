//
//  TabViewTest.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/26/22.
//

import SwiftUI

class HomeViewViewModel: ObservableObject {
    @Published var toggleFlag = false {
        didSet {
            print("vm changed to", self.toggleFlag)
        }
    }
}

struct HomeView: View {
    @StateObject var vm = HomeViewViewModel()
    @State var flag = false
    
    var body: some View {
        ZStack {
            Color.pink.ignoresSafeArea().opacity(0.3)
            VStack {
                Toggle(isOn: $vm.toggleFlag) {
                    Text("var vm")
                }
                Toggle("var flag", isOn: $flag)
            }
            .padding()
            
        }.onChange(of: flag) { newValue in
            print("flag changed to", newValue)
        }
        
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


