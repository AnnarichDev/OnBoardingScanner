//
//  OnBoardingScannerHelper.swift
//  BSImagePicker
//
//  Created by NB1003917 on 29/2/2567 BE.
//

import Photos

public class Helper {
    
    public static let shared = Helper()
    static let minimumCharacter = 20
    
    /// Convert `PHAsset`  to `UIImage`
    func convertAssetToImage(asset: PHAsset, completionHandler: ((UIImage?) -> Void)? ) {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        manager.requestImage(for: asset,
                             targetSize: PHImageManagerMaximumSize,
                             contentMode: .aspectFill,
                             options: option,
                             resultHandler: { (image, info) in
            completionHandler?(image)
        })
    }

    
    /// Convert `UIImage` to `String`
    func string(from image: UIImage) -> String {
        
        var qrAsString = ""
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                        context: nil,
                                        options: [CIDetectorAccuracy: CIDetectorAccuracyHigh]),
              let ciImage = CIImage(image: image),
              let features = detector.features(in: ciImage) as? [CIQRCodeFeature] else {
            return qrAsString
        }
        
        for feature in features {
            guard let indeedMessageString = feature.messageString else {
                continue
            }
            qrAsString += indeedMessageString
        }
        
        return qrAsString
    }
}
