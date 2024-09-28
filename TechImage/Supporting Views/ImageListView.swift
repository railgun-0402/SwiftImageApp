//
//  ImageListView.swift
//  TechImage
//
// 画像リスト

import SwiftUI

struct ImageListView: View {
    @EnvironmentObject private var userData: UserData
    
    let id: Int
    
    var body: some View {
        HStack {
            if self.userData.images.count > 0 {
                // 画像が取得できるなら表示
                Image(uiImage: UIImage.init(contentsOfFile: self.userData.images[self.id].path)!) // パスから画像の取得&表示
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50, alignment: .center)
                
                // 名称
                Text(self.userData.images[self.id].name)
                
                // 余白は画面一杯
                Spacer()
                
                Group {
                    // お気に入りなら色付きハートを出す
                    if self.userData.images[self.id].isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundColor(Color.pink)
                    } else {
                        Image(systemName: "heart")
                            .foregroundColor(Color.gray)
                    }
                }
                
                .onTapGesture {
                    // お気に入り値の反転
                    self.userData.images[self.id].isFavorite.toggle()
                    
                    saveFavorite(name: self.userData.images[self.id].name,
                                 isFavorite: self.userData.images[self.id].isFavorite)
                }
                
            } else {
                // 残念ながら画像が取れない場合は一旦これ
                Text("None")
            }
        }
    }
}

#Preview {
    ImageListView(id: 0).environmentObject(UserData())
}
