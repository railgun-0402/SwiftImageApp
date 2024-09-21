//
//  Album.swift
//  TechImage
//

import SwiftUI

struct Album: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("全ての項目")
                Text("お気に入り")
            }
            .navigationBarTitle(Text("アルバム"))
        }
    }
}

#Preview {
    Album()
}
