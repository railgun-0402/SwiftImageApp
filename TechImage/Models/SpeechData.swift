//
//  SpeechData.swift
//  TechImage
//

import Foundation

final class SpeechData: ObservableObject {
    // 回転フラグ
    @Published var isRotation = false
    
    private var speech: SpeechRecognizer = SpeechRecognizer()
    
    // 許可ダイアログ
    func authorization() {
        self.speech.authrization()
    }
    
    func start() {
        
        do {
            try self.speech.start() { [weak self] (isRotation: Bool) -> Void in
                
                // error
                guard let self = self else {
                    return
                }
                
                if self.isRotation != isRotation {
                    self.isRotation = isRotation
                }
            }
        } catch {
            print("音声認識に失敗しました")
        }
    }
    
    func stop() {
        self.speech.stop()
        self.isRotation = false
    }
}
