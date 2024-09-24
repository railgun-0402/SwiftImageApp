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
    
    var body: some View {
        List {
            ForEach (self.userData.images) { item in
                ImageListView(id: item.id)
            }
        }
        .navigationBarTitle(Text("画像リスト"))
    }
}

#Preview {
    ImageList().environmentObject(UserData())
}
