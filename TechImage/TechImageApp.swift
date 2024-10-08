//
//  TechImageApp.swift
//  TechImage
//


import SwiftUI

@main
struct TechImageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var userData = UserData()
    
    var body: some Scene {
        WindowGroup {
            Album()
                .environmentObject(userData)
            
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let UserDefaults = UserDefaults.standard
        
        // お気に入り情報に空配列をデフォルト値として設定
        UserDefaults.register(defaults: [UserDefaultKey.arrayFavorite: []])
        
        return true
    }
}
