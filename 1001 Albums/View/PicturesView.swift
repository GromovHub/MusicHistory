//
//  Pictures.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/18/22.
//

import SwiftUI

class PicturesViewModel: ObservableObject {
    @Published var model = CompletionHandler()
    func getImages2() -> [UIImage] {
        sleep(2)
        return [UIImage(data: model.results[1]!)!]
        
    }
    
    func getImages() -> [UIImage] {
        model.getImages { cdata, cid in
            self.model.appendDataFunc(data: cdata, id: cid)
        }
        sleep(2)
        var resultImages = [UIImage]()
        for i in 1...model.results.count {
            guard let imageData = model.results[i] else {
                print("error imagedata")
                return resultImages
            }
            guard let uiImage = UIImage(data: imageData) else {
                print("error uiIamage")
                return resultImages
            }
            resultImages.append(uiImage)
        }
        return resultImages
    }
}

struct PicturesView: View {
    @StateObject var vm = PicturesViewModel()
    @State var images = [UIImage]()
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.getImages(), id: \.self) { i in
                    Image(uiImage: i)
                }
            }.onAppear {
//                images = vm.getImages()
            }
        }
    }
}

struct Pictures_Previews: PreviewProvider {
    static var previews: some View {
        PicturesView()
    }
}
