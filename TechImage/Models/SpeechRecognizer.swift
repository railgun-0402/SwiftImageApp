//
//  SpeechRecognizer.swift
//  TechImage
//

import Foundation
import Speech

//MARK:- Speech

class SpeechRecognizer {
    // 音の管理
    private let audioEngine = AVAudioEngine()
    
    // マイクから取得した音声バッファを音声認識に渡す
    private var speechRequest: SFSpeechAudioBufferRecognitionRequest?
    
    // 音声認識を日本語に
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    
    // 音声認識タスクを生成
    private var speechTask: SFSpeechRecognitionTask?
    
    // 音声認識許可
    func authrization() {
        SFSpeechRecognizer.requestAuthorization {(authStatus) in
            switch authStatus {
            case .authorized:
                print("許可")
                
            case .denied:
                print("拒否")
            
            case .restricted:
                print("未対応")
                
            case .notDetermined:
                print("未認証")
                
            default:
                print("上記以外")
            }
            
            
        }
    }
    
    // 音声認識を開始
    func start(completion: @escaping (Bool) -> Void) throws {
        // 音声認識タスクがすでに開始している場合、キャンセル
        if let speechTask = speechTask {
            speechTask.cancel()
            self.speechTask = nil
        }
        
        // 音声バッファを認識に渡す
        self.speechRequest = SFSpeechAudioBufferRecognitionRequest()
        
        self.speechTask = self.speechRecognizer.recognitionTask(with: self.speechRequest!) { [weak self] (result, error) in
            
            // error
            guard let self = self else {
                return
            }
            
            var isFinal = false
            
            if let result = result {
                // これで音声認識の結果を取得できる
                let seg = result.bestTranscription.segments.last
                print(seg!.substring)
                
                if seg!.substring == "回れ" {
                    completion(true)
                }
                
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                
                // 音声認識を修了
                self.audioEngine.stop()
                self.audioEngine.inputNode.removeTap(onBus: 0)
                self.speechRequest = nil
                self.speechTask = nil
            }
        }
        
        // マイク
        let recordFormat = self.audioEngine.inputNode.outputFormat(forBus: 0)
        
        // 前回実行時に監視していたパスを削除
        self.audioEngine.inputNode.removeTap(onBus: 0)
        
        // マイクから取得した音声を音声認識に渡す
        self.audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordFormat) { [weak self] (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            
            // error
            guard let self = self else {
                return
            }
            
            // 音声バッファ追加
            self.speechRequest?.append(buffer)
        }
        
        // マイク音取得
        self.audioEngine.prepare()
        try? self.audioEngine.start()
    }
    
    // 音声認識を停止
    func stop() {
        self.audioEngine.stop()
        self.speechRequest?.endAudio()
        self.speechTask?.cancel()
        self.speechRequest = nil
        self.speechTask = nil
    }
}
