# SwiftImageApp
## 概要
### 内容 
iOSのアプリとして、アルバム(画像)管理アプリを開発中。

### 目的
前にクイズアプリやゴルフスコアアプリを作成し、3つ目のリリースを企んでいる。

SwiftUIもやってみたかったので、シンプルなアプリをリリースしよう！

デプロイは未定

## 使用技術(作成中なので予定も含む)
- Swift5
- Xcode16
- iOS18

## feature
- アルバムの表示
- 写真数の表示
- iPhone内から写真を取得
- 写真ごとにアルバムを作成する

UnitTestはXCTestあたりを検討中

## 音声認識
- AVAudioEngine
  - マイクから音声データをバッファ(一時的なメモリ領域)に取得
- SFSpeechRecognizer
  - 上記で取得した音声を、`SFSpeechAudioBufferRecognitionRequest` から受け取り解析&文字列化
- SFSpeechAudioBufferRecognitionRequest
  - マイクから取得した音声バッファを音声認識に渡す
  - https://developer.apple.com/documentation/speech/sfspeechaudiobufferrecognitionrequest
