//
//  UIImage+Filter.swift
//  TechImage
//

import UIKit

//MARK:- UIImage

extension UIImage {
    // グレースケール (インスタンスメソッド)
    func graySclade() -> UIImage {
        // グラフィックスコンテキスト作成
        guard let context = CGContext(data:nil,
                                      width: Int(self.size.width),
                                      height: Int(self.size.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: CGColorSpaceCreateDeviceGray(),
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue) else {
            return UIImage.init()
        }
        
        // CGImage
        guard let originalCGImage = self.cgImage else {
            return UIImage.init()
        }
        
        // グラフィックスコンテキストに画像処理
        context.draw(originalCGImage, in: CGRect(x: 0,
                                                 y: 0,
                                                 width: self.size.width,
                                                 height: self.size.height))
        
        // グラフィックスコンテキストからCGImageに変換
        let grayScaleCGImageWrap: CGImage? = context.makeImage()
        
        guard let grayScaleCGImage = grayScaleCGImageWrap else {
            return UIImage.init()
        }
        
        // CGImage -> UIImage
        let grayScaleImageWrap: UIImage? = UIImage(cgImage: grayScaleCGImage)
        
        guard let grayScaleImage = grayScaleImageWrap else {
            return UIImage.init()
        }
        
        return grayScaleImage
    }
    
    // セピア (クラスメソッド)
    class func sepia(path: String) -> UIImage {
        // CIImageで画像作成
        let ciImageWrap: CIImage? = CIImage(contentsOf: URL(fileURLWithPath: path))
        
        guard let ciImage = ciImageWrap else {
            return UIImage.init()
        }
        
        // CIFilterでセピア設定
        let ciFilterWrap: CIFilter? = CIFilter(name: "CISepiaTone")
        
        guard let ciFilter = ciFilterWrap else {
            return UIImage.init()
        }
        
        // セピアフィルター処理
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        ciFilter.setValue(1.0, forKey: "inputIntensity")
        
        // CIImageでセピア画像作成
        let sepiaCIImageWrap: CIImage? = ciFilter.outputImage
        
        guard let sepiaCIImage = sepiaCIImageWrap else {
            return UIImage.init()
        }
        
        // CIImage -> CGImage
        let ciContext: CIContext = CIContext(options: nil)
        let cgImageWrap: CGImage? = ciContext.createCGImage(sepiaCIImage,
                                                            from:sepiaCIImage.extent)
        
        guard let cgImage = cgImageWrap else {
            return UIImage.init()
        }
        
        // CGImage -> UIImage
        let sepiaImageWrap: UIImage? = UIImage(cgImage: cgImage, scale: 0.0,
                                               orientation:UIImage.Orientation.up)
        
        guard let sepiaImage = sepiaImageWrap else {
            return UIImage.init()
        }
        
        return sepiaImage
    }
}
