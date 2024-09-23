//
//  AlbumView.swift
//  TechImage
//

import SwiftUI

struct AlbumView: View {
    @EnvironmentObject private var userData: UserData
    
    // property
    let name: String
    let path: String
    let isFavorite: Bool
    
    init(name: String, path: String, isFavorite: Bool) {
        self.name = name
        self.path = path
        self.isFavorite = isFavorite
    }
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            ZStack {
                
                Group {
                    // 画像のファイルパスが設定されている
                    if self.path.count > 0 {
                        // pathで画像ファイルパス設定
                        Image(uiImage: UIImage.init(contentsOfFile: self.path)!)
                            .renderingMode(.original)
                            .frame(width: 100, height: 100, alignment: .center)
                    } else {
                        Image(systemName: "square.on.square")
                            .renderingMode(.original)
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                    
                    // お気に入り
                    if self.isFavorite {
                        // ハート表示
                        Image(systemName: "heart.fill")
                            .frame(width: 100, height: 100, alignment: .bottomLeading)
                            .foregroundColor(.pink)
                    }
                }
                .padding()
                .border(Color.gray, width: 1)
            }
            .cornerRadius(10)
            
            // 名称
            Text(self.name)
                .foregroundColor(.primary)
            
            // 画像数
            Group {
                if self.isFavorite {
                    Text("0")
                } else {
                    Text(String(self.userData.images.count))
                }
            }
            .foregroundColor(.primary)
        }
    }
}

#Preview {
    AlbumView(name: "Tagosaku", path: "", isFavorite: true).environmentObject(UserData())
}
