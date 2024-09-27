//
//  Setting.swift
//  TechImage
//

import Foundation

//MARK:- Favorite

struct UserDefaultKey {
    static let arrayFavorite: String = "arrayFavorite"
    static let isAppInit: String = "isAppInit"
    static let appVersion: String = "appVersion"
}


// お気に入り情報の保存
func saveFavorite(name: String, isFavorite: Bool) {
    // お気に入り情報の取得
    let isFavoriteArrayWrap = UserDefaults.standard.stringArray(forKey: UserDefaultKey.arrayFavorite)
    
    // お気に入りがない
    guard var isFavoriteArray = isFavoriteArrayWrap else {
        return
    }
    
    if isFavorite {
        isFavoriteArray.append(name)
    } else {
        if let index = isFavoriteArray.firstIndex(of: name) {
            isFavoriteArray.remove(at: index)
        }
    }
    
    // お気に入りを保存
    UserDefaults.standard.set(isFavoriteArray, forKey: UserDefaultKey.arrayFavorite)
    
    return
}

// お気に入り情報の取得
func loadFavorite() -> Array<String> {
    let isFavoriteArrayWrap = UserDefaults.standard.stringArray(forKey: UserDefaultKey.arrayFavorite)
    
    guard let isFavoriteArray = isFavoriteArrayWrap else {
        return []
    }
    
    return isFavoriteArray
}

// お気に入りの数を取得
func countFavorite(images: Array<ImageInfo>) -> Int {
    var count = 0
    
    for item in images {
        if item.isFavorite {
            count += 1
        }
    }
    
    return count
}
