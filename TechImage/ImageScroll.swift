//
//  ImageScroll.swift
//  TechImage
//

import SwiftUI

struct ImageScroll: View {
    @EnvironmentObject private var userData: UserData
    
    // お気に入り判定
    var onlyFavorite: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.userData.images) {item in
                    
                    // お気に入りのみ表示もしくは全ての項目を表示
                    if (self.onlyFavorite &&
                        item.isFavorite) ||
                        self.onlyFavorite == false {
                        
                        Image(uiImage: UIImage.init(contentsOfFile: item.path)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            // infinity: スクロールビューで表示される全ビューを合わせた高さが設定
        }.frame(maxHeight: .infinity)
            .navigationBarTitle(Text("画像スクロール"))
    }
}

#Preview {
    ImageScroll(onlyFavorite: false).environmentObject(UserData())
}
