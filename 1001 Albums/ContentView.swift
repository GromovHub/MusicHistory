//
//  ContentView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    
    var controller = Controller()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.small)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
