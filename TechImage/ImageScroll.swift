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
    
    // 音声データクラス作成
    @ObservedObject private var speech: SpeechData = SpeechData()
    
    // 編集モード(編集:active 完了：inactive)
    @State private var isEditMode: EditMode = .inactive
    // 画像処理
    @State private var kindImage: Int = KindStructImage.regular
    // 音声認識フラグ
    @State private var isSpeech: Bool = false
    
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
                            }
                        }
                        .aspectRatio(contentMode: .fit)
                        
                        // 回転のアニメーション
                        .rotationEffect(.degrees(self.speech.isRotation ? 360 : 0))
                        .animation(self.speech.isRotation ? self.animation : .none)
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
                    
                    Spacer()
                    
                    // 音声認識ボタン
                    Button(action: {
                        
                        if self.isSpeech {
                            self.speech.stop()
                            
                        } else {
                            self.speech.start()
                        }
                        self.isSpeech.toggle()
                    }) {
                        
                        // マイク画像
                        if self.isSpeech {
                            Image(systemName: "mic")
                                .foregroundColor(Color.red)
                        }
                        else {
                            Image(systemName: "mic")
                                .foregroundColor(Color.green)
                        }
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
        .onAppear(perform: speechAuthorization)
        .onDisappear(perform: speechStop)
    }
    
    // 詳細なアニメーション設定
    var animation: Animation {
        
        Animation.interpolatingSpring(mass: 1,
                                      stiffness: 2,
                                      damping: 0.8,
                                      initialVelocity: 2)
        .speed(2)
    }

    // 音声認識を停止します
    func speechStop() {
        self.speech.stop()
    }

    // 音声認識の許可ダイアログを表示します
    func speechAuthorization() {
        self.speech.authorization()
    }
}




#Preview {
    ImageScroll(onlyFavorite: false).environmentObject(UserData())
}
