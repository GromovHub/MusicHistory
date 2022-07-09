//
//  FileManagerView.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 6/16/22.
//

import SwiftUI

struct FileManagerView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 400)
                        .clipped()
                        .cornerRadius(20)
                }
                Button {
                    //button code
                    vm.changeName(name: "cat")
                    vm.getImageFromAssets()
                } label: {
                    Text("Save to FM")
                        .foregroundColor(.white)
                        
                        .font(.headline)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }.navigationTitle(Text("File Manager"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerView()
    }
}
