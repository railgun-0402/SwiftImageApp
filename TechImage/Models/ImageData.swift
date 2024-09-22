//
//  ImageData.swift
//  TechImage
//

import Foundation

struct ImageInfo: Identifiable {
    let id: Int
    let name: String
    var path: String
    var isFavorite: Bool
}

// 画像情報を保持
let imageInfos: [ImageInfo] = loadImageInfos()

// ~/Documentsフォルダ内の画像ファイルを全て取得
func loadImageInfos() -> Array<ImageInfo> {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                            .userDomainMask,
                                                            true)[0]
    
    guard var fileNames = try? FileManager.default.contentsOfDirectory(atPath: documentsPath) else {
        return []
    }
    
    // ファイル名称でソート
    fileNames.sort {$0 < $1}
    
    let favoriteArray: Array<String> = []
    var imageInfos: Array<ImageInfo> = []
    
    // ファイル情報を全て配列に入れる
    var idNum = 0
    for name: String in fileNames {
        // お気に入り判定
        var isFavorite = false
        if favoriteArray.contains(name) == true {
            isFavorite = true
        }
        
        // Documentsフォルダパスにファイル名称を追加してファイルパスを作成
        let path = documentsPath + "/" + name
        
        // 構造体を作成
        let imageInfo = ImageInfo(id: idNum, name: name, path: path, isFavorite: isFavorite)
        
        imageInfos.append(imageInfo)
        idNum += 1
    }
    
    return imageInfos
}
