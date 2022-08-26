//
//  AppStorage2.swift
//  MusicHistory
//
//  Created by Vitaly Gromov on 8/25/22.
//

import SwiftUI

struct AppStorage2: View {
    @AppStorage("myValue") var myValue = 0
    var body: some View {
        NavigationView {
            VStack {
                Text("ap2")
                Text("\(myValue)")
                    .onTapGesture {
                        myValue += 1
                    }
                NavigationLink("next") {
                    AppStorage3()
                }
            }
            
        }
    }
}

struct AppStorage3: View {
    @AppStorage("myValue") var myValue = 0
    var body: some View {
        NavigationView {
            VStack {
                Text("ap3")
                Text("\(myValue)")
                    .onTapGesture {
                        myValue += 1
                    }
                NavigationLink("next") {
                    AppStorage4()
                }
            }
            
        }
    }
}
struct AppStorage4: View {
    @AppStorage("myValue") var myValue = 0
    var body: some View {
        NavigationView {
            VStack {
                Text("ap4")
                Text("\(myValue)")
                    .onTapGesture {
                        myValue += 1
                    }
                NavigationLink("next") {
                    AppStorage2()
                }
            }
            
        }
    }
}

struct AppStorage2_Previews: PreviewProvider {
    static var previews: some View {
        AppStorage2()
    }
}
