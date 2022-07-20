//
//  AsyncImageDownloader.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 7/20/22.
//

import SwiftUI

class AsyncImageDownloaderModel {
    init() {}
    func getImageDataFromAPI(howMany: Int) async -> [Data]{
        var dataResults = [Data]()
        for i in 0...howMany {
            do {
                let (data, _) = try await URLSession.shared.data(from: URL(string: "https://picsum.photos/300")!)
                dataResults.append(data)
                print("item \(i) added.", data)
            } catch {
                print("error from get image data", error)
            }
        }
        return dataResults
    }
}

@MainActor
class AsyncImageDownloaderViewModel: ObservableObject {
    init() {}
    @Published var model = AsyncImageDownloaderModel()
    @Published var results = [UIImage]()
    
    func fetchImages() {
        Task {
            let imageData = await model.getImageDataFromAPI(howMany: 10)
            for i in imageData {
                guard let image = UIImage(data: i) else {
                    continue
                }
                self.results.append(image)
            }
        }
    }
}

struct AsyncImageDownloader: View {
    @StateObject var vm = AsyncImageDownloaderViewModel()
    var body: some View {
        NavigationView {
            if vm.results.isEmpty {
                VStack {
                    Text("image fetching")
                    ProgressView()
                        .navigationTitle("Images from picsum")
                }
            } else {
                ScrollView {
                    VStack {
                        ForEach(vm.results, id: \.self) { i in
                            Image(uiImage: i)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }.navigationTitle("Images from picsum")
            }
        }
        .onAppear {
            vm.fetchImages()
        }
    }
}

struct AsyncImageDownloader_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageDownloader()
    }
}
