//
//  Album.swift
//  TechImage
//

import SwiftUI

struct Album: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ImageList(onlyFavorite: false)) {
                    AlbumView(name: "全ての項目",
                              path: self.userData.images.count > 0 ? self.userData.images[0].path : "",
                              isFavorite: false)
                }
                
                NavigationLink(destination: ImageList(onlyFavorite: true)) {
                    AlbumView(name: "お気に入り",
                              path: self.userData.images.count > 1 ? self.userData.images[1].path : "",
                              isFavorite: true)
                }
                
            }
            .navigationBarTitle(Text("アルバム"))
        }
    }
}

#Preview {
    Album().environmentObject(UserData())
}
