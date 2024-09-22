//
//  Album.swift
//  TechImage
//

import SwiftUI

struct Album: View {
    var body: some View {
        NavigationView {
            VStack {
                AlbumView(name: "全ての項目",
                          path: "",
                          isFavorite: false)
                AlbumView(name: "お気に入り",
                          path: "",
                          isFavorite: true)
                
            }
            .navigationBarTitle(Text("アルバム"))
        }
    }
}

#Preview {
    Album()
}
