//
//  1001_AlbumsApp.swift
//  1001 Albums
//
//  Created by Vitaly Gromov on 6/16/22.
//

import SwiftUI
import FirebaseCore

// firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
@main
struct ThousandAlbumsApp: App {
//    let x: Void = ItunesComparator.singleton.getItunesJson()
//    let y: Void = ItunesComparator.singleton.problemCounter()
//    let z: Void = CustomDecodeEncode.decodingProf()
    // firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    // view changer
    var body: some Scene {
        WindowGroup {
//            ThousandListView()
//            TestView1()
//            PicturesView()
//            AsyncImageDownloader()
//            ViewPublishTest()
//            LazyVGridView()
            TabViewTest()
//            SignUpView()
//            TestPublisher()
//            FirebaseTest()
            
        }
    }
}
