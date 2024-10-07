//
//  ImageScroll.swift
//  TechImage
//

import SwiftUI

struct KindStructImage {
    static let regular: Int = 0     // 何もしない
    static let grayscale: Int = 1   // グレースケール
    static let colorInvert: Int = 2 // 色調反転
    static let sepia: Int = 3       // セピア
}

struct ImageScroll: View {
    @EnvironmentObject private var userData: UserData
    
    // 編集モード(編集:active 完了：inactive)
    @State private var isEditMode: EditMode = .inactive
    
    // 画像処理
    @State private var kindImage: Int = KindStructImage.regular
    
    // お気に入り判定
    var onlyFavorite: Bool
    
    var body: some View {
        GeometryReader { geometry in // セーフエリア外マージンなどを取得
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: true) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        ForEach(self.userData.images) { item in
                            
                            if  (self.onlyFavorite == true &&
                                 item.isFavorite) ||
                                    self.onlyFavorite == false {
                                
                                // ==========ここから編集します==========
                                
                                // グレースケール
                                if self.kindImage == KindStructImage.grayscale {
                                    Image(uiImage: (UIImage.init(contentsOfFile: item.path)?.graySclade())!)
                                        .resizable()
                                }
                                // 色調反転
                                else if self.kindImage == KindStructImage.colorInvert {
                                    Image(uiImage: UIImage.init(contentsOfFile: item.path)!)
                                        .resizable()
                                        .colorInvert()
                                    
                                }
                                // セピア
                                else if self.kindImage == KindStructImage.sepia {
                                    Image(uiImage: UIImage.sepia(path: item.path))
                                        .resizable()
                                }
                                // 通常
                                else {
                                    Image(uiImage: UIImage.init(contentsOfFile: item.path)!)
                                        .resizable()
                                }
                                
                                // ==========ここまで編集します==========
                            }
                        }
                        // ここに追加します
                        .aspectRatio(contentMode: .fit)
                    }
                }
                
            }
            
            // 編集状態の場合、ツールバー表示
            if self.isEditMode == .active {
                HStack {
                    Image(systemName: "photo")
                        .foregroundColor(Color.gray)
                        .onTapGesture {
                            self.kindImage = KindStructImage.grayscale
                        }
                    
                    Spacer()
                    
                    Button(action: {
                        // 色調反転状態にする
                        self.kindImage = KindStructImage.colorInvert
                    }) {
                        Image(systemName: "photo.fill")
                            .foregroundColor(Color.blue)
                    }
                    Spacer()
                    
                    Button(action: {
                        // セピア状態
                        self.kindImage = KindStructImage.sepia
                    }) {
                        Image(systemName: "photo.on.rectangle")
                            .foregroundColor(Color.yellow)
                    }
                }
                // アイコンとツールバーの間に余白
                .padding()
                // ツールバーの高さとアイコンの表示位置を設定します
                .frame(height: 44+geometry.safeAreaInsets.bottom, alignment: .top)
                
                // ツールバーの背景色を白に設定します
                .background(Color.white)
            }
        }
        .frame(maxHeight: .infinity)
        .navigationBarTitle(Text("画像スクロール"))
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarItems(trailing: EditButton())
        .environment(\.editMode, self.$isEditMode)
    }
}


#Preview {
    ImageScroll(onlyFavorite: false).environmentObject(UserData())
}
