//
//  ImageList.swift
//  TechImage
//

import SwiftUI

/*
 * 画像リスト画面
 */
struct ImageList: View {
    @EnvironmentObject private var userData: UserData
    
    var onlyFavorite: Bool
    
    var body: some View {
        List {
            ForEach (self.userData.images) { item in
                if (self.onlyFavorite == true &&
                    item.isFavorite) ||
                    self.onlyFavorite == false {
                    ImageListView(id: item.id)
                }
            }
        }
        .navigationBarTitle(Text("画像リスト"))
    }
}

#Preview {
    ImageList(onlyFavorite: false).environmentObject(UserData())
}
